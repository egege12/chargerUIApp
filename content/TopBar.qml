import QtQuick 2.15
import QtQuick.Controls 6.3
import QtQuick.Layouts 1.0
Rectangle {
    id: buttonbarrect
    signal iconSizeClicked()
    signal escapeClicked()
    signal fullScreenClicked()
    property int buttonRadius : 1
    property real buttonOpacity : 0.4

        width: parent.width
        height: 30
    MouseArea{
            width:105
            height:parent.height
            anchors.right:parent.right
            anchors.top:parent.top
            hoverEnabled: true
            onEntered: buttonbarrect.buttonOpacity = 1
            onExited: buttonbarrect.buttonOpacity = 0.4

            MenuButton {
                id : buttonIconSize
                width: 35
                height: parent.height
                buttonImageSource : "images/iconIconSizeButton.png"
                clip: false
                buttonOpacity: buttonbarrect.buttonOpacity
                visible: true
                radius: buttonbarrect.buttonRadius
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                hoveredColor:"#d6d4d4"
                pressedColor: "#4f4e4e"
                releasedColor: "#878686"
                onButtonClicked: buttonbarrect.iconSizeClicked()

            }

            MenuButton {
                id : buttonFullscreen
                width: 35
                height: parent.height
                buttonImageSource : "images/iconFullscreenButton.png"
                clip: false
                buttonOpacity: buttonbarrect.buttonOpacity
                visible: true
                radius: buttonbarrect.buttonRadius
                anchors.left: buttonIconSize.right
                anchors.verticalCenter: parent.verticalCenter
                hoveredColor:"#d6d4d4"
                pressedColor: "#4f4e4e"
                releasedColor: "#878686"
                onButtonClicked: buttonbarrect.fullScreenClicked()

            }
            MenuButton {
                id : escapeButton
                width: 35
                height: parent.height
                buttonImageSource : "images/iconEscapeButton.png"
                clip: false
                buttonOpacity: buttonbarrect.buttonOpacity
                visible: true
                radius: buttonbarrect.buttonRadius
                anchors.left: buttonFullscreen.right
                anchors.verticalCenter: parent.verticalCenter
                hoveredColor:"#f00505"
                pressedColor: "#969595"
                releasedColor: "#a80303"
                onButtonClicked: buttonbarrect.escapeClicked()

            }

        }


}
