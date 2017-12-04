import QtQuick 2.2
import Sailfish.Silica 1.0

Dialog {
    anchors.fill: parent
    allowedOrientations: defaultAllowedOrientations
    property url    imageUrl: ""
    property string messageText: ""

    onImageUrlChanged: currentImage.source = imageUrl

    DialogHeader {
        id: dialogHeader
        acceptText: qsTr("Send image")
        cancelText: qsTr("Cancel")
//        title: qsTr("Send Image")
    }

    SilicaFlickable
    {
        anchors.fill: parent
        Image {
            id: currentImage
            height: parent.height * 0.33
            source: imageSendPage.imageUrl
            anchors {
                top: dialogHeader.bottom
                left: parent.left
                right: parent.right
                topMargin: Theme.paddingMedium
            }
            fillMode:  Image.PreserveAspectFit
            asynchronous: true
    //        autoTransform : true
        }

        TextArea {
            id: message
            anchors {
                top: currentImage.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                topMargin: Theme.paddingMedium
                leftMargin: Theme.paddingMedium
                rightMargin: Theme.paddingMedium
                bottomMargin: Theme.paddingMedium
            }

            onTextChanged: messageText = text
        }
    }
}

