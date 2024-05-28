import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
Item {
    id: sideBar

    width: 0
    height: 768
    state: 'noside'
    anchors.left: parent.left
    property int indexPage : 0
    property string sideBarState: "noside"
    property bool isDesktop: true;
    /*Side bar controls here */
    signal openSideBar;
    signal closeSideBar;
    signal noSideBar;


    onCloseSideBar: {
        sideBar.state='close'
        sideBarState = sideBar.state
    }
    onOpenSideBar: {
        sideBar.state='open'
         sideBarState = sideBar.state
    }
    onNoSideBar: {
        //if(sideBar.isDesktop ===false){
            sideBar.state='noside'
            sideBarState = sideBar.state
            indexPage=1
        //}
    }

    states: [
        State {
            name: 'noside'

            PropertyChanges {
                target: sideBar
                width: 0
            }

            PropertyChanges {
                target: timer
                index: 0
            }
        },
        State {
            name: 'open'

            PropertyChanges {
                target: sideBar
                width: 174
            }

            PropertyChanges {
                target: timer
                index: 0
            }
        },
        State {
            name: 'close'

            PropertyChanges {
                target: sideBar
                width: 100
            }

            PropertyChanges {
                target: timer
                index: 0
            }
        }

    ]

    transitions: [
        Transition {
            from: 'close'
            to: 'open'

            NumberAnimation {
                properties: 'width'
                duration: 300
                easing.type: Easing.OutCubic
            }

            ScriptAction {
                script: {
                    timer.start();
                }
            }
        },
        Transition {
            from: 'open'
            to: 'close'

            SequentialAnimation {

                ScriptAction {
                    script: {
                        timer.start();
                    }
                }

                PauseAnimation {
                    duration: 600
                }

                NumberAnimation {
                    properties: 'width'
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        },
        Transition {
            from: 'open'
            to: 'noside'

            SequentialAnimation {

                ScriptAction {
                    script: {
                        timer.start();
                    }
                }

                PauseAnimation {
                    duration: 600
                }

                NumberAnimation {
                    properties: 'width'
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        },
        Transition {
            from: 'noside'
            to: 'open'

            NumberAnimation {
                properties: 'width'
                duration: 300
                easing.type: Easing.OutCubic
            }

            ScriptAction {
                script: {
                    timer.start();
                }
            }
        },
        Transition {
            from: 'close'
            to: 'noside'

            SequentialAnimation {

                ScriptAction {
                    script: {
                        timer.start();
                    }
                }

                PauseAnimation {
                    duration: 600
                }

                NumberAnimation {
                    properties: 'width'
                    duration: 300
                    easing.type: Easing.OutCubic
                }
            }
        },
        Transition {
            from: 'noside'
            to: 'close'

            NumberAnimation {
                properties: 'width'
                duration: 300
                easing.type: Easing.OutCubic
            }

            ScriptAction {
                script: {
                    timer.start();
                }
            }
        }

    ]

    Timer {
        id: timer

        property int index: 0

        interval: 50

        onTriggered: {
            if (sideBar.state == 'open')
                columnItems.itemAt(index).state = 'left';
            else if (sideBar.state == 'close')
                columnItems.itemAt(index).state = 'middle';
            else
                columnItems.itemAt(index).state = 'noside';
            if (++index != 9)
                timer.start();
        }
    }


    Rectangle {
        id: body

        radius: 0
        color: '#23992b'
        anchors.fill: parent

        ColumnLayout {
            id: buttonColumn

            width: parent.width
            spacing: 10
            anchors { top: parent.top; topMargin: 30 }

            Repeater {
                id: columnItems

                model: ['Menu', 'Charge', 'Events', 'Details', 'Interface', 'Parameters', 'Settings','Profile','Logout']
                delegate: Rectangle {
                    id: button

                    Layout.preferredWidth: 60
                    Layout.preferredHeight: 60
                    radius: 10
                    color:sideBar.indexPage === model.index ? '#F2EFEF' : buttonMouseArea.containsMouse ? ((model.index == 5 || model.index == 6 || model.index == 7)? 'transparent':'#F2EFEF'):'transparent'
                    Layout.alignment: Qt.AlignLeft
                    Layout.topMargin: model.index === 1 ? 20 : 0
                    state: 'noside'

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                        }
                    }

                    states: [
                        State {
                            name: 'left'

                            PropertyChanges {
                                target: button
                                Layout.leftMargin: 5
                                Layout.preferredWidth: (model.index !== 0 && model.index !== 8)  ? 145 : 60
                            }

                            PropertyChanges {
                                target: title
                                opacity: 1
                            }
                        },
                        State {
                            name: 'middle'

                            PropertyChanges {
                                target: button
                                Layout.leftMargin: Math.ceil((sideBar.width - 60) / 2)
                                Layout.preferredWidth: 60
                            }

                            PropertyChanges {
                                target: title
                                opacity: 0
                            }
                        },
                        State {
                            name: 'noside'

                            PropertyChanges {
                                target: button
                                visible:0
                                Layout.preferredWidth: 0
                            }

                            PropertyChanges {
                                target: title
                                opacity: 0
                            }
                        }
                    ]

                    transitions: [
                        Transition {
                            from: 'middle'
                            to: 'left'

                            NumberAnimation {
                                properties: 'Layout.leftMargin, Layout.preferredWidth, opacity'
                                duration: 300
                                easing.type: Easing.BezierSpline
                            }
                        },
                        Transition {
                            from: 'left'
                            to: 'middle'

                            NumberAnimation {
                                properties: 'Layout.leftMargin, Layout.preferredWidth, opacity'
                                duration: 300
                                easing.type: Easing.InOutSine
                            }
                        },
                        Transition {
                            from: 'left'
                            to: 'noside'

                            NumberAnimation {
                                properties: 'Layout.leftMargin, Layout.preferredWidth, opacity'
                                duration: 300
                                easing.type: Easing.InOutSine
                            }
                        },
                        Transition {
                            from: 'middle'
                            to: 'noside'

                            NumberAnimation {
                                properties: 'Layout.leftMargin, Layout.preferredWidth, opacity'
                                duration: 300
                                easing.type: Easing.InOutSine
                            }
                        }
                    ]

                    MouseArea {
                        id: buttonMouseArea

                        hoverEnabled: true
                        anchors.fill: parent
                        onClicked: {
                            if (model.index === 0) {
                                if (sideBar.state == 'close')
                                    sideBar.openSideBar();
                                else
                                    sideBar.closeSideBar();
                            }else if(model.index=== 8){
                                    sideBar.noSideBar();
                             }
                                else{
                                if(model.index !== 5 && model.index !== 6 && model.index !== 7)
                                   sideBar.indexPage = model.index
                            }


                        }



                    }

                    Image {
                        id: icon

                        source: 'icons/' + modelData + '.svg'
                        sourceSize: Qt.size(50, 50)
                        anchors { verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: 5 }
                        z:3
                    }

                    Text {
                        id: title

                        text: (model.index === 0 || model.index === 8)  ? '' : modelData
                        font.family: "Helvetica"
                        anchors { verticalCenter: parent.verticalCenter; left: parent.left; leftMargin: 65 }
                        z:2
                    }


                }
            }


        }
    }
    DropShadow {
        id: shadow
        anchors.fill: body
        source: body
        radius: 20
        samples: radius * 2 + 1
        color: Qt.rgba(0, 0, 0, 0.05)
    }
}
