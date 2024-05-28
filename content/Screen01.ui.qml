import QtQuick 6.2
import QtQuick.Controls 6.2

import chargerUI

Rectangle {
    id: rectangle
    height: 768
    width: 1024
    opacity: 1
    color: "transparent"
    clip: true
    property bool plugged1: false
    property bool plugged2: false
    onPlugged1Changed: rectangleQrorPlug1Clip.visible = !rectangle.plugged1
    onPlugged2Changed: rectangleQrorPlug2Clip.visible = !rectangle.plugged2

    Rectangle {
        id: rectangleEvse1Header
        anchors.right: parent.horizontalCenter
        anchors.rightMargin: parent.width * .09
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: parent.height * .35
        width: parent.width * .40
        height: 60
        color: '#23992b'
        radius: 20
        opacity: 0.5
        border.width: 0
    }
    Rectangle {
        id: rectangleQrorPlug1
        anchors.horizontalCenter: rectangleEvse1Header.horizontalCenter
        anchors.top: rectangleEvse1Header.bottom
        anchors.topMargin: parent.height * .05
        width: parent.width * .25
        height: parent.height * .70
        color: '#23992b'
        radius: 20
        opacity: 0.5
        border.width: 0
        clip: true
    }
    Rectangle {
        id: rectangleQrorPlug1Clip
        anchors.horizontalCenter: rectangleEvse1Header.horizontalCenter
        anchors.top: rectangleEvse1Header.bottom
        anchors.topMargin: parent.height * .05
        width: parent.width * .25
        height: parent.height * .70
        color: 'transparent'
        radius: 20
        opacity: 1
        border.width: 0
        clip: true
        visible: true
        Image {
            id: plugEvse1
            width: rectangleQrorPlug1Clip.width * .7
            source: "images/plug.webp"
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: rectangleQrorPlug1Clip.verticalCenter
            anchors.verticalCenterOffset: rectangleQrorPlug1Clip.height * 0.37
            anchors.horizontalCenter: rectangleQrorPlug1Clip.horizontalCenter
        }
        Rectangle {
            id: rectangle1
            anchors.verticalCenter: rectangleQrorPlug1Clip.verticalCenter
            anchors.horizontalCenter: rectangleQrorPlug1Clip.horizontalCenter
            anchors.horizontalCenterOffset: rectangleQrorPlug1Clip.width * 0.25
            width: rectangleQrorPlug1Clip.width * 0.35
            height: 4
            color: "#ffffff"
            radius: 50
        }
        Rectangle {
            id: rectangle2
            anchors.verticalCenter: rectangleQrorPlug1Clip.verticalCenter
            anchors.horizontalCenter: rectangleQrorPlug1Clip.horizontalCenter
            anchors.horizontalCenterOffset: -rectangleQrorPlug1Clip.width * 0.25
            width: rectangleQrorPlug1Clip.width * 0.35
            height: 4
            color: "#ffffff"
            radius: 50
        }
        Text {
            id: evse1QrPlugText
            anchors.bottom: plugEvse1.top
            anchors.bottomMargin: 10
            anchors.horizontalCenter: rectangleQrorPlug1Clip.horizontalCenter
            width: qrEvse1.width
            height: 43
            color: "#ffffff"
            text: qsTr("PLUG IN")
            font.pixelSize: 32
            horizontalAlignment: Text.AlignHCenter
            font.wordSpacing: 0
            font.styleName: "Bold"
            font.family: "Tahoma"
        }
        Text {
            id: evse1orText
            anchors.verticalCenter: rectangleQrorPlug1Clip.verticalCenter
            anchors.horizontalCenter: rectangleQrorPlug1Clip.horizontalCenter
            width: qrEvse1.width
            height: 25
            color: "#ffffff"
            text: qsTr("or")
            font.pixelSize: 22
            horizontalAlignment: Text.AlignHCenter
            font.wordSpacing: 0
            font.styleName: "Bold"
            font.family: "Tahoma"
        }
    }
    Text {
        id: evse1QrScanText
        anchors.bottom: qrEvse1.top
        anchors.bottomMargin: 5
        anchors.horizontalCenter: qrEvse1.horizontalCenter
        width: qrEvse1.width
        height: 43
        color: "#ffffff"
        text: qsTr("SCAN")
        font.pixelSize: 32
        horizontalAlignment: Text.AlignHCenter
        font.wordSpacing: 0
        font.styleName: "Bold"
        font.family: "Tahoma"
    }

    Image {
        id: qrEvse1
        width: rectangleQrorPlug1.width * .70
        source: "icons/BozankayaQr.png"
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: rectangleQrorPlug1.verticalCenter
        anchors.verticalCenterOffset: rectangleQrorPlug1Clip.visible ? (-rectangleQrorPlug1.height
                                                                        * 0.23) : 0
        anchors.horizontalCenter: rectangleQrorPlug1.horizontalCenter
    }
    Image {
        id: rfidRead
        width: rectangleQrorPlug1.width * .50
        source: "icons/RFIDread.webp"
        fillMode: Image.PreserveAspectFit
        anchors.top: qrEvse1.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: rectangleQrorPlug1.horizontalCenter
        visible: !rectangleQrorPlug1Clip.visible
    }

    Text {
        id: evse1Text
        anchors.left: rectangleEvse1Header.left
        anchors.leftMargin: 20
        anchors.verticalCenter: rectangleEvse1Header.verticalCenter
        width: 204
        height: 43
        color: "#ffffff"
        text: qsTr("CSS 2 EVSE 1")
        font.pixelSize: 32
        font.wordSpacing: 0
        font.styleName: "Normal"
        font.family: "Tahoma"
    }
    Text {
        id: evse1Power
        width: 100
        height: 43
        color: "#ffffff"
        text: qsTr("120kW")
        anchors.verticalCenter: rectangleEvse1Header.verticalCenter
        anchors.right: rectangleEvse1Header.right
        anchors.rightMargin: 20
        font.pixelSize: 32
        horizontalAlignment: Text.AlignRight
        font.wordSpacing: 0
        font.styleName: "Normal"
        font.family: "Tahoma"
    }

    Rectangle {
        id: rectangleEvse2Header
        width: parent.width * .40
        height: 60
        color: '#23992b'
        radius: 20
        opacity: 0.5
        border.width: 0
        anchors.left: parent.horizontalCenter
        anchors.leftMargin: parent.width * .09
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: parent.height * .35
    }
    Rectangle {
        id: rectangleQrorPlug2
        anchors.horizontalCenter: rectangleEvse2Header.horizontalCenter
        anchors.top: rectangleEvse2Header.bottom
        anchors.topMargin: parent.height * .05
        width: parent.width * .25
        height: parent.height * .70
        color: '#23992b'
        radius: 20
        opacity: 0.5
        border.width: 0
    }
    Rectangle {
        id: rectangleQrorPlug2Clip
        anchors.horizontalCenter: rectangleEvse2Header.horizontalCenter
        anchors.top: rectangleEvse2Header.bottom
        anchors.topMargin: parent.height * .05
        width: parent.width * .25
        height: parent.height * .70
        color: 'transparent'
        radius: 20
        opacity: 1
        border.width: 0
        clip: true
        Image {
            id: plugEvse2
            width: rectangleQrorPlug2Clip.width * .7
            source: "images/plug.webp"
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: rectangleQrorPlug2Clip.verticalCenter
            anchors.verticalCenterOffset: rectangleQrorPlug2Clip.height * 0.37
            anchors.horizontalCenter: rectangleQrorPlug2Clip.horizontalCenter
        }
        Rectangle {
            id: rectangle3
            anchors.verticalCenter: rectangleQrorPlug2Clip.verticalCenter
            anchors.horizontalCenter: rectangleQrorPlug2Clip.horizontalCenter
            anchors.horizontalCenterOffset: rectangleQrorPlug2Clip.width * 0.25
            width: rectangleQrorPlug2Clip.width * 0.35
            height: 4
            color: "#ffffff"
            radius: 50
        }
        Rectangle {
            id: rectangle4
            anchors.verticalCenter: rectangleQrorPlug2Clip.verticalCenter
            anchors.horizontalCenter: rectangleQrorPlug2Clip.horizontalCenter
            anchors.horizontalCenterOffset: -rectangleQrorPlug2Clip.width * 0.25
            width: rectangleQrorPlug2Clip.width * 0.35
            height: 4
            color: "#ffffff"
            radius: 50
        }
        Text {
            id: evse2QrPlugText
            anchors.bottom: plugEvse2.top
            anchors.bottomMargin: 10
            anchors.horizontalCenter: rectangleQrorPlug2Clip.horizontalCenter
            width: qrEvse2.width
            height: 43
            color: "#ffffff"
            text: qsTr("PLUG IN")
            font.pixelSize: 32
            horizontalAlignment: Text.AlignHCenter
            font.wordSpacing: 0
            font.styleName: "Bold"
            font.family: "Tahoma"
        }
        Text {
            id: evse2orText
            anchors.verticalCenter: rectangleQrorPlug2Clip.verticalCenter
            anchors.horizontalCenter: rectangleQrorPlug2Clip.horizontalCenter
            width: qrEvse1.width
            height: 25
            color: "#ffffff"
            text: qsTr("or")
            font.pixelSize: 22
            horizontalAlignment: Text.AlignHCenter
            font.wordSpacing: 0
            font.styleName: "Bold"
            font.family: "Tahoma"
        }
    }

    Text {
        id: evse2QrScanText
        anchors.bottom: qrEvse2.top
        anchors.bottomMargin: 5
        anchors.horizontalCenter: qrEvse2.horizontalCenter
        width: qrEvse2.width
        height: 43
        color: "#ffffff"
        text: qsTr("SCAN")
        font.pixelSize: 32
        horizontalAlignment: Text.AlignHCenter
        font.wordSpacing: 0
        font.styleName: "Bold"
        font.family: "Tahoma"
    }
    Image {
        id: qrEvse2
        width: rectangleQrorPlug2.width * .70
        source: "icons/BozankayaQr.png"
        fillMode: Image.PreserveAspectFit
        anchors.verticalCenter: rectangleQrorPlug2.verticalCenter
        anchors.verticalCenterOffset: rectangleQrorPlug2Clip.visible ? (-rectangleQrorPlug2.height
                                                                        * 0.23) : 0
        anchors.horizontalCenter: rectangleQrorPlug2.horizontalCenter
    }
    Image {
        id: rfidRead2
        width: rectangleQrorPlug2.width * .50
        source: "icons/RFIDread.webp"
        fillMode: Image.PreserveAspectFit
        anchors.top: qrEvse2.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: rectangleQrorPlug2.horizontalCenter
        visible: !rectangleQrorPlug2Clip.visible
    }

    Text {
        id: evse2Text
        anchors.left: rectangleEvse2Header.left
        anchors.leftMargin: 20
        anchors.verticalCenter: rectangleEvse2Header.verticalCenter

        width: 204
        height: 43
        color: "#ffffff"
        text: qsTr("CSS 2 EVSE 1")
        font.pixelSize: 32
        font.wordSpacing: 0
        font.styleName: "Normal"
        font.family: "Tahoma"
    }
    Text {
        id: evse2Power
        width: 100
        height: 43
        color: "#ffffff"
        text: qsTr("120kW")
        anchors.verticalCenter: rectangleEvse2Header.verticalCenter
        anchors.right: rectangleEvse2Header.right
        anchors.rightMargin: 20
        font.pixelSize: 32
        horizontalAlignment: Text.AlignRight
        font.wordSpacing: 0
        font.styleName: "Normal"
        font.family: "Tahoma"
    }
}
