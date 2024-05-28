import QtQuick 6.2
import QtQuick.Controls 6.2

import chargerUI

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
        anchors.verticalCenterOffset: -20
        anchors.right: parent.right
        anchors.rightMargin: parent.width * .05
        width: parent.width * .70
        height: topoImage.height
        color: '#fafafa'
        radius: 10
        opacity: 0.7
        border.width: 0
        clip: true

        Image {
            id: topoImage
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width
            source: "images/topology.svg"
            fillMode: Image.PreserveAspectFit
        }
    }
}
