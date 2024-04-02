// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.2
import chargerUI

Window {
    id: root
    width: 1024
    height: 768
    visible: true
    property bool fullscreen
    property bool iconSize
    property bool darkmode:false
    property bool naviBarActive:false
    Component.onCompleted: {
        root.showFullScreen()
    }
    flags: Qt.FramelessWindowHint | Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint  // to hide windows window and still show minimized icon
    title: qsTr("Charger UI")
    color:"transparent"
    Rectangle{
        anchors.fill:parent
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

        Screen01 {
            id: mainScreen
            anchors.fill:parent
        }
    }
    DragHandler {
        onActiveChanged: if(active) startSystemMove();
    }
    //     //ButtonBar{
    //     //    id:windowButtonBar
    //     //    anchors.verticalCenter: parent.verticalCenter
    //     //    anchors.right:parent.right
    //     //    onFullScreenClicked:{
    //     //        if(fullscreen === true){
    //     //            root.showNormal()
    //     //        }else{
    //     //            root.showFullScreen()
    //     //        }
    //     //        fullscreen= !fullscreen}
    //     //    onIconSizeClicked: {
    //     //        if(iconSize === true){
    //     //            root.showNormal()
    //     //        }else{
    //     //            root.showMinimized()
    //     //        }
    //     //        iconSize= !iconSize}
    //     //    onEscapeClicked: Qt.quit()
    //     //}
    // MouseArea {
    //     id: mouseArea
    //     anchors.fill: parent
    //     hoverEnabled: true
    //     acceptedButtons: Qt.LeftButton
    //     z:1
    //     property int edges: 2;
    //     property int edgeOffest: 5;

    //     function setEdges(x, y) {
    //         edges = 0;
    //         if(x < edgeOffest) edges |= Qt.LeftEdge;
    //         if(x > (width - edgeOffest))  edges |= Qt.RightEdge;
    //         if(y < edgeOffest) edges |= Qt.TopEdge;
    //         if(y > (height - edgeOffest)) edges |= Qt.BottomEdge;
    //     }

    //     cursorShape: {
    //         return !containsMouse ? Qt.ArrowCursor:
    //                                 edges == 3 || edges == 12 ? Qt.SizeFDiagCursor :
    //                                                             edges == 5 || edges == 10 ? Qt.SizeBDiagCursor :
    //                                                                                         edges & 9 ? Qt.SizeVerCursor :
    //                                                                                                     edges & 6 ? Qt.SizeHorCursor : Qt.ArrowCursor;
    //     }

    //     onPositionChanged: setEdges(mouseX, mouseY);
    //     onPressed: {
    //         setEdges(mouseX, mouseY);
    //         if(edges && containsMouse) {
    //             startSystemResize(edges);
    //         }
    //     }
    // }


}

