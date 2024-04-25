// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.2
import QtQuick.Controls 6.2
import chargerUI

Window {
    id: root
    width: 1024
    height: 768
    minimumWidth: 1024
    minimumHeight: 768
    visible: true

    property bool isDesktop:true   // Compile for desktop

    /*START MenuBar properties*/
    property bool fullscreen
    property bool iconSize
    property bool darkmode:false
    /*END MenuBar properties */

    /*START SideBar properties*/

    /*END SideBar properties*/

    /*Make fullscreen when component loaded on charger screen*/

    /*Activate frameless, use qt window features*/
    flags: Qt.FramelessWindowHint | Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint  // to hide windows window and still show minimized icon
    title: qsTr("Charger UI")
    color:"#F2EFEF"
    Rectangle{
        anchors.fill:parent
        z:2
        color:"transparent"
        gradient: Gradient {
            GradientStop {
                position: 0
                color: (root.darkmode === true) ? "#000000" : "#FFFFFF"
            }

            GradientStop {
                position: (root.darkmode === true) ?  0.84018 : 0.42466
                color: (root.darkmode === true) ? "#000000" : "#949494"
            }

            GradientStop {
                position: 1
                color: "#262727"
            }
            orientation: Gradient.Vertical
        }


        TopBar{
            id:windowButtonBar
            anchors.top: parent.top
            anchors.topMargin:0
            anchors.right:parent.right
            anchors.rightMargin:0
            height: 25
            width: parent.width
            onFullScreenClicked:{
                if(fullscreen === true){
                    root.showNormal()
                }else{
                    root.showFullScreen()
                }
                fullscreen= !fullscreen}
            onIconSizeClicked: {
                if(iconSize === true){
                    root.showNormal()
                }else{
                    root.showMinimized()
                }
                iconSize= !iconSize}
            onEscapeClicked: Qt.quit()
            visible: root.isDesktop
            z:5
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                spacing :  5
                height:parent.height
            Button{
                width:100
                height:parent.height
                text: qwTr("Open")
                onPressed: {
                    sideBar.openSideBar()
                }
            }
            Button{
                width:100
                height:parent.height
                text: qwTr("Close")
                onPressed: {
                    sideBar.closeSideBar()
                }
            }
            Button{
                width:100
                height:parent.height
                text: qwTr("Noside")
                onPressed: {
                    sideBar.noSideBar()
                }
            }
            }

        }
        SideBar{
            id:sideBar
            anchors.top:windowButtonBar.bottom
            anchors.bottom:parent.bottom
            z:4
            onIndexPageChanged: {
                if(indexPage == 1){
                    contentLoader.source= "Screen01.ui.qml"
                }else if(indexPage == 2){
                    contentLoader.source= "Screen02.ui.qml"
                }
            }
        }


        Item{
            id:contentfield
            anchors.top:root.isDesktop ? windowButtonBar.bottom : parent.top
            anchors.left:sideBar.right
            anchors.bottom:root.bottom
            anchors.right:root.right
            state:'Charge'
            Loader{
                id:contentLoader
                focus:true
                source: "Screen01.ui.qml"

                // Fade-out eski içerik, fade-in yeni içerik
                onLoaded: {
                            // Yeni içerik yüklendiğinde başlatılacak fade-in animasyonu
                            fadeInAnimation.start();
                        }

                        // Fade-in animasyonu
                        NumberAnimation {
                            id: fadeInAnimation
                            target: contentLoader.item
                            property: "opacity"
                            from: 0
                            to: 1
                            duration: 500
                        }

            }
        }


    }
    DragHandler {
        onActiveChanged: if(active) startSystemMove();
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton
        z:1
        property int edges: 2;
        property int edgeOffest: 5;

        function setEdges(x, y) {
            edges = 0;
            if(x < edgeOffest) edges |= Qt.LeftEdge;
            if(x > (width - edgeOffest))  edges |= Qt.RightEdge;
            if(y < edgeOffest) edges |= Qt.TopEdge;
            if(y > (height - edgeOffest)) edges |= Qt.BottomEdge;
        }

        cursorShape: {
            return !containsMouse ? Qt.ArrowCursor:
                                    edges == 3 || edges == 12 ? Qt.SizeFDiagCursor :
                                                                edges == 5 || edges == 10 ? Qt.SizeBDiagCursor :
                                                                                            edges & 9 ? Qt.SizeVerCursor :
                                                                                                        edges & 6 ? Qt.SizeHorCursor : Qt.ArrowCursor;
        }

        onPositionChanged: setEdges(mouseX, mouseY);
        onPressed: {
            setEdges(mouseX, mouseY);
            if(edges && containsMouse) {
                startSystemResize(edges);
            }
        }
        visible:isDesktop
    }

    Component.onCompleted: {
        if(root.isDekstop === false){
            root.showFullScreen()
            sideBar.noSideBar()
        }else{
            sideBar.closeSideBar()
        }

    }
    Connections{
        target:internalOp
        onIdResult:{
            sideBar.openSideBar();
        }
    }

}

