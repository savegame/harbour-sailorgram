import QtQuick 2.6
import Sailfish.Silica 1.0
import harbour.telega.LibQTelegram 1.0
import "../../components/custom"
import "../../components/peer"
import "../../model"

Page {
    id: detailspage
    allowedOrientations: defaultAllowedOrientations
    property Context context
    property var dialog

    PeerProfile {
        id: peerprofile
        telegram: context.telegram
        peer: detailspage.dialog
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: content.height

        Column {
            id: content
            width: parent.width
            spacing: Theme.paddingMedium
            topPadding: Theme.paddingLarge

            PeerImage {
                id: peerimage
                anchors.horizontalCenter: parent.horizontalCenter
                size: Screen.width * 0.3
                peer: detailspage.dialog
            }

            Label {
                id: lbltitle
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Theme.paddingSmall
                    rightMargin: Theme.paddingSmall
                }
                horizontalAlignment: Text.AlignHCenter
                font.family: Theme.fontFamilyHeading
                font.bold: true
                elide: Text.ElideRight

                text: {
                    if(peerprofile.hasUsername) {
                        return "%1 (@%2)".arg(peerprofile.title)
                                         .arg(peerprofile.username);
                    }

                    return peerprofile.title;
                }
            }

            Label {
                id: lblstatus
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: Theme.paddingSmall
                    rightMargin: Theme.paddingSmall
                }
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.highlightColor
                elide: Text.ElideRight
                text: peerprofile.statusText.toLocaleString()
            }

            Column {
                id: coldata
                width: parent.width - 2 * Theme.paddingMedium
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    margins: Theme.paddingMedium
                }
                spacing: Theme.paddingLarge
                property int fontSize: Theme.fontSizeMedium

                Column {
                    id: colinfo
                    visible: peerprofile.hasPhoneNumber

                    Label {
                        id: lblinfo
                        font.pixelSize: coldata.fontSize
                        color: Theme.highlightColor
                        text: qsTr("Info")
                    }

                    Label {
                        id: phonenum
                        x: Theme.paddingLarge
                        font.pixelSize: coldata.fontSize
                        color: Theme.primaryColor
                        text: qsTr("Phone number: %1").arg(peerprofile.phoneNumber)
                    }
                }

                Column {
                    id: colsettings

                    Label {
                        id: lblsettings
                        font.pixelSize: coldata.fontSize
                        color: Theme.highlightColor
                        text: qsTr("Settings")
                    }

                    TextSwitch {
                         id: notificationSwitch
                         text: qsTr("Notifications")
                         checked: !peerprofile.isMuted
                         onCheckedChanged: {
                             peerprofile.isMuted = !checked
                         }
                    }
                }
            }
        }
    }
}
