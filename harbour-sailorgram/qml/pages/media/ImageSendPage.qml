import QtQuick 2.2
import QtQuick.Window 2.2
import Sailfish.Silica 1.0
import Sailfish.Gallery 1.0
import Sailfish.Gallery.private 1.0

Dialog {
    id: imageSendPageDialog
    anchors.fill: parent
    allowedOrientations: defaultAllowedOrientations
    property url    imageUrl: ""
    property string messageText: ""
    property bool sendCompressed: true

    onImageUrlChanged: currentImage.source = imageUrl
    signal sendUncopmressed()


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

        TextSwitch {
            id: cbox
            anchors {
                top: parent.top
                left: parent.left
                right:parent.right
                topMargin:Theme.paddingMedium
            }
            text: qsTr("Comress")
            description: qsTr("Send image with comression")
            //:
            //state: ComboBox::Checked
            checked: true
            onCheckedChanged: {
                if (checked === true)
                    description = qsTr("Send image with comression")
                else
                    description = qsTr("Send image without comression, as file");
                imageSendPageDialog.sendCompressed = checked
            }
        }


        Image {
            id: currentImage
            height: Screen.desktopAvailableHeight * 0.33
            source: imageSendPage.imageUrl
            anchors {
                top: cbox.bottom
                left: parent.left
                right: parent.right
                topMargin: Theme.paddingMedium
                leftMargin: Theme.paddingMedium
                rightMargin: Theme.paddingMedium
            }
            fillMode:  Image.PreserveAspectFit
            //autoTransform: true
            asynchronous: true

            ImageMetadata {
                id: metadata

                source: imageSendPage.imageUrl
                autoUpdate: false
            }
            onSourceChanged :
            {
                metadata.source = source
                //rotation:  -metadata.orientatio
                anchors.top = cbox.bottom
                anchors.left = parent.left
                anchors.right = parent.right
                anchors.topMargin = Theme.paddingMedium
                anchors.leftMargin = Theme.paddingMedium
                anchors.rightMargin = Theme.paddingMedium
            }

            rotation:  -metadata.orientation
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

        contentHeight: cbox.height + message.height + currentImage.height
    }

    DialogHeader {
        id: dialogHeader
        dialog: imageSendPageDialog
        acceptText: qsTr("Send image")
        cancelText: qsTr("Cancel")
        //        title: qsTr("Send Image")
    }
}

