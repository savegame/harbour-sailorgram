import QtQuick 2.2
import QtQuick.Window 2.2
import Sailfish.Silica 1.0

Dialog {
    id: imageSendPageDialog
    anchors.fill: parent
    allowedOrientations: defaultAllowedOrientations
    property url    imageUrl: ""
    property string messageText: ""

    onImageUrlChanged: currentImage.source = imageUrl

    SilicaFlickable
    {
        id: flick
        anchors{
            top: dialogHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        ScrollDecorator {
            id: flickable
            flickable: flick
        }

        Image {
            id: currentImage
            height: Screen.desktopAvailableHeight * 0.33
            source: imageSendPage.imageUrl
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: Theme.paddingMedium
            }
            fillMode:  Image.PreserveAspectFit
            asynchronous: true
        }

        TextArea {
            id: message
            //height: Screen.desktopAvailableHeight * 0.33
            anchors {
                top: currentImage.bottom
                left: parent.left
                right: parent.right
                //bottom: parent.bottom
                topMargin: Theme.paddingMedium
                leftMargin: Theme.paddingMedium
                rightMargin: Theme.paddingMedium
                bottomMargin: Theme.paddingMedium
            }

            onTextChanged: messageText = text
        }

        contentHeight: message.height + currentImage.height
    }

    DialogHeader {
        id: dialogHeader
        acceptText: qsTr("Send image")
        cancelText: qsTr("Cancel")
    //        title: qsTr("Send Image")
    }
}

