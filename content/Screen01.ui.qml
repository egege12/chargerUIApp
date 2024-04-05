import QtQuick 6.2
import QtQuick.Controls 6.2

import chargerUI

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    opacity: 1
    color: "#46000000"

    property bool buttonState: true

    Connections {
        target: rectangle
        onButtonStateChanged: button.text = "press again"
    }

    Grid {
        id: grid
        x: 0
        y: 0
        width: 1024
        height: 768
        topPadding: 30
        rightPadding: 60
        leftPadding: 60
        spacing: 15
        rows: 2
        columns: 2

        Rectangle {
            id: rectangle1
            width: 440
            height: 100
            color: "#e3243038"
            border.width: 0

            Text {
                id: text2
                x: 25
                width: 204
                height: 43
                color: "#ffffff"
                text: qsTr("CSS 2 EVSE 1")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
                font.pixelSize: 32
                font.wordSpacing: 0
                font.styleName: "Normal"
                font.family: "Tahoma"
            }

            Text {
                id: text4
                x: 281
                width: 149
                height: 43
                color: "#ffffff"
                text: qsTr("90kW")
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 20
                font.pixelSize: 32
                horizontalAlignment: Text.AlignRight
                font.wordSpacing: 0
                font.styleName: "Normal"
                font.family: "Tahoma"
            }
        }

        Rectangle {
            id: rectangle2
            x: 0
            width: 440
            height: 100
            color: "#e3243038"
            border.width: 0

            Text {
                id: text1
                width: 204
                height: 43
                color: "#ffffff"
                text: qsTr("CSS 2 EVSE 2")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 20
                font.pixelSize: 32
                font.wordSpacing: 0
                font.styleName: "Normal"
                font.family: "Tahoma"
            }

            Text {
                id: text3
                x: 286
                width: 149
                height: 43
                color: "#ffffff"
                text: qsTr("90kW")
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 20
                font.pixelSize: 32
                horizontalAlignment: Text.AlignRight
                font.wordSpacing: 0
                font.styleName: "Normal"
                font.family: "Tahoma"
            }
        }

        Rectangle {
            id: rectangle3
            width: 440
            height: 550
            color: "#e3243038"
            border.width: 0

            Text {
                id: text5
                x: 20
                width: 341
                height: 162
                color: "#c15300"
                text: qsTr("Soketi Takın")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 23
                anchors.topMargin: 206
                font.pixelSize: 62
                wrapMode: Text.WordWrap
                anchors.verticalCenterOffset: -47
                font.wordSpacing: 0
                font.styleName: "Kalın"
                font.family: "Tahoma"
            }

            Text {
                id: text7
                x: 20
                width: 351
                height: 150
                color: "#ffffff"
                text: qsTr("Şarja başlamak için")
                elide: Text.ElideLeft
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 23
                anchors.topMargin: 27
                font.pixelSize: 62
                lineHeightMode: Text.ProportionalHeight
                wrapMode: Text.WordWrap
                layer.enabled: false
                layer.smooth: true
                layer.mipmap: true
                layer.wrapMode: ShaderEffectSource.Repeat
                font.hintingPreference: Font.PreferNoHinting
                styleColor: "#ffffff"
                style: Text.Normal
                font.capitalization: Font.SmallCaps
                fontSizeMode: Text.FixedSize
                font.wordSpacing: 0
                font.styleName: "Kalın"
                font.family: "Tahoma"
                anchors.verticalCenterOffset: -173
            }

            Image {
                id: plug
                y: 163
                width: 492
                height: 406
                anchors.left: parent.left
                anchors.leftMargin: 0
                source: "images/plug.png"
                fillMode: Image.PreserveAspectFit
            }
        }

        Rectangle {
            id: rectangle4
            width: 440
            height: 550
            color: "#e3243038"
            border.width: 0
            Text {
                id: text6
                x: 20
                width: 341
                height: 162
                color: "#c15300"
                text: qsTr("Soketi Takın")
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 23
                anchors.topMargin: 206
                font.pixelSize: 62
                wrapMode: Text.WordWrap
                font.wordSpacing: 0
                font.styleName: "Kalın"
                font.family: "Tahoma"
                anchors.verticalCenterOffset: -47
            }

            Text {
                id: text8
                x: 20
                width: 351
                height: 150
                color: "#ffffff"
                text: qsTr("Şarja başlamak için")
                elide: Text.ElideLeft
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 23
                anchors.topMargin: 27
                font.pixelSize: 62
                lineHeightMode: Text.ProportionalHeight
                wrapMode: Text.WordWrap
                styleColor: "#ffffff"
                style: Text.Normal
                layer.wrapMode: ShaderEffectSource.Repeat
                layer.smooth: true
                layer.mipmap: true
                layer.enabled: false
                fontSizeMode: Text.FixedSize
                font.wordSpacing: 0
                font.styleName: "Kalın"
                font.hintingPreference: Font.PreferNoHinting
                font.family: "Tahoma"
                font.capitalization: Font.SmallCaps
                anchors.verticalCenterOffset: -173
            }

            Image {
                id: plug1
                y: 165
                width: 492
                height: 406
                anchors.left: parent.left
                anchors.leftMargin: 0
                source: "images/plug.png"
                fillMode: Image.PreserveAspectFit
            }
        }
    }
    states: [
        State {
            name: "clicked"
        }
    ]
}
