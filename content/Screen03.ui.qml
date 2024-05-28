import QtQuick 6.2
import QtQuick.Controls 6.2
import QtQuick.Layouts 1.15

Rectangle {
    id: rectangle
    width: 1024
    height: 768
    opacity: 1
    color: "transparent"
    clip: true
    property bool buttonState: true

    Rectangle {
        id: rectangleMain
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: parent.width * .03
        width: 650
        height: 700
        color: '#777877'
        radius: 10
        opacity: 0.7
        border.width: 0
        clip: true
        ScrollView {
            anchors.fill: parent
            TableView {
                id: tableView
                anchors.fill: parent
                columnSpacing: 0
                rowSpacing: 0
                model: ListModel {
                    ListElement {
                        eventNo: "DDS No"
                        priority: "Priorty"
                        startTime: "Start Time"
                        finishTime: "End Time"
                        description: "Description"
                    }
                    ListElement {
                        eventNo: "1001"
                        priority: "A"
                        startTime: "2023-05-01 08:00"
                        finishTime: "2023-05-01 10:00"
                        description: "Contactor malfunction"
                    }
                    ListElement {
                        eventNo: "1002"
                        priority: "B"
                        startTime: "2023-05-02 09:00"
                        finishTime: "2023-05-02 11:30"
                        description: "Connection issue"
                    }
                    ListElement {
                        eventNo: "1003"
                        priority: "C"
                        startTime: "2023-05-03 10:15"
                        finishTime: "2023-05-03 12:45"
                        description: "Communication failure"
                    }
                    ListElement {
                        eventNo: "1004"
                        priority: "D"
                        startTime: "2023-05-04 11:30"
                        finishTime: "2023-05-04 14:00"
                        description: "Charging interruption"
                    }
                    ListElement {
                        eventNo: "1005"
                        priority: "E"
                        startTime: "2023-05-05 13:00"
                        finishTime: "2023-05-05 15:30"
                        description: "Power supply failure"
                    }
                    ListElement {
                        eventNo: "1006"
                        priority: "A"
                        startTime: "2023-05-06 14:00"
                        finishTime: "2023-05-06 16:30"
                        description: "Overheating"
                    }
                    ListElement {
                        eventNo: "1007"
                        priority: "B"
                        startTime: "2023-05-07 15:15"
                        finishTime: "2023-05-07 17:45"
                        description: "Software error"
                    }
                    ListElement {
                        eventNo: "1008"
                        priority: "C"
                        startTime: "2023-05-08 16:30"
                        finishTime: "2023-05-08 19:00"
                        description: "Hardware failure"
                    }
                    ListElement {
                        eventNo: "1009"
                        priority: "D"
                        startTime: "2023-05-09 17:45"
                        finishTime: "2023-05-09 20:15"
                        description: "Network issue"
                    }
                    ListElement {
                        eventNo: "1010"
                        priority: "E"
                        startTime: "2023-05-10 18:00"
                        finishTime: "2023-05-10 20:30"
                        description: "Unexpected shutdown"
                    }
                    ListElement {
                        eventNo: "1011"
                        priority: "A"
                        startTime: "2023-05-11 08:00"
                        finishTime: "2023-05-11 10:00"
                        description: "Voltage fluctuation"
                    }
                    ListElement {
                        eventNo: "1012"
                        priority: "B"
                        startTime: "2023-05-12 09:00"
                        finishTime: "2023-05-12 11:30"
                        description: "Temperature sensor failure"
                    }
                    ListElement {
                        eventNo: "1013"
                        priority: "C"
                        startTime: "2023-05-13 10:15"
                        finishTime: "2023-05-13 12:45"
                        description: "Cooling system failure"
                    }
                    ListElement {
                        eventNo: "1014"
                        priority: "D"
                        startTime: "2023-05-14 11:30"
                        finishTime: "2023-05-14 14:00"
                        description: "Battery failure"
                    }
                    ListElement {
                        eventNo: "1015"
                        priority: "E"
                        startTime: "2023-05-15 13:00"
                        finishTime: "2023-05-15 15:30"
                        description: "Power surge"
                    }
                    ListElement {
                        eventNo: "1016"
                        priority: "A"
                        startTime: "2023-05-16 14:00"
                        finishTime: "2023-05-16 16:30"
                        description: "Current overload"
                    }
                    ListElement {
                        eventNo: "1017"
                        priority: "B"
                        startTime: "2023-05-17 15:15"
                        finishTime: "2023-05-17 17:45"
                        description: "Sensor calibration error"
                    }
                    ListElement {
                        eventNo: "1018"
                        priority: "C"
                        startTime: "2023-05-18 16:30"
                        finishTime: "2023-05-18 19:00"
                        description: "Relay failure"
                    }
                    ListElement {
                        eventNo: "1019"
                        priority: "D"
                        startTime: "2023-05-19 17:45"
                        finishTime: "2023-05-19 20:15"
                        description: "Inverter error"
                    }
                    ListElement {
                        eventNo: "1020"
                        priority: "E"
                        startTime: "2023-05-20 18:00"
                        finishTime: "2023-05-20 20:30"
                        description: "Ground fault"
                    }
                    ListElement {
                        eventNo: "1021"
                        priority: "A"
                        startTime: "2023-05-21 08:00"
                        finishTime: "2023-05-21 10:00"
                        description: "Insulation failure"
                    }
                    ListElement {
                        eventNo: "1022"
                        priority: "B"
                        startTime: "2023-05-22 09:00"
                        finishTime: "2023-05-22 11:30"
                        description: "Cooling fan error"
                    }
                    ListElement {
                        eventNo: "1023"
                        priority: "C"
                        startTime: "2023-05-23 10:15"
                        finishTime: "2023-05-23 12:45"
                        description: "Capacitor failure"
                    }
                    ListElement {
                        eventNo: "1024"
                        priority: "D"
                        startTime: "2023-05-24 11:30"
                        finishTime: "2023-05-24 14:00"
                        description: "Diode failure"
                    }
                    ListElement {
                        eventNo: "1025"
                        priority: "E"
                        startTime: "2023-05-25 13:00"
                        finishTime: "2023-05-25 15:30"
                        description: "Rectifier failure"
                    }

                    // Diğer satırlar burada olacak
                }

                delegate: RowLayout {
                    spacing: 0

                    Rectangle {
                        width: tableView.width * 0.1
                        height: model.index == 0 ? 20 : 30
                        color: model.index == 0 ? "gray" : "lightgray"
                        border.color: "black"
                        Text {
                            anchors.centerIn: parent
                            text: model.eventNo
                            font.pixelSize: 16
                        }
                    }
                    Rectangle {
                        width: tableView.width * 0.08
                        height: model.index == 0 ? 20 : 30
                        color: model.index == 0 ? "gray" : "lightgray"
                        border.color: "black"
                        Text {
                            anchors.centerIn: parent
                            text: model.priority
                            font.pixelSize: 16
                        }
                    }
                    Rectangle {
                        width: tableView.width * 0.21
                        height: model.index == 0 ? 20 : 30
                        color: model.index == 0 ? "gray" : "lightgray"
                        border.color: "black"
                        Text {
                            anchors.centerIn: parent
                            text: model.startTime
                            font.pixelSize: 16
                        }
                    }
                    Rectangle {
                        width: tableView.width * 0.21
                        height: model.index == 0 ? 20 : 30
                        color: model.index == 0 ? "gray" : "lightgray"
                        border.color: "black"
                        Text {
                            anchors.centerIn: parent
                            text: model.finishTime
                            font.pixelSize: 16
                        }
                    }
                    Rectangle {
                        width: tableView.width * 0.4
                        height: model.index == 0 ? 20 : 30
                        color: model.index == 0 ? "gray" : "lightgray"
                        border.color: "black"
                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            text: model.description
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignLeft
                        }
                    }
                }
            }
        }
    }
}
