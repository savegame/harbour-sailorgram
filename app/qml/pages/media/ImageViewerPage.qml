import QtQuick 2.1
import Sailfish.Silica 1.0
import "../../components/custom"

Page
{
    property alias source: image.source

    signal saveToDownloadsRequested()

    id: mediaphotopage
    allowedOrientations: defaultAllowedOrientations

    MessagePopup { id: messagepopup }

    SilicaFlickable
    {
        id: flickable
        anchors.fill: parent

        PullDownMenu
        {
            MenuItem
            {
                text: qsTr("Save to downloads");

                onClicked: {
                    saveToDownloadsRequested()
                    messagepopup.popup(qsTr("Image saved to downloads folder"));
                }
            }
        }

        Image {
            id: image
            anchors {
                centerIn: parent
                fill: parent
            }
            fillMode: Image.PreserveAspectFit
        }
    }
}
