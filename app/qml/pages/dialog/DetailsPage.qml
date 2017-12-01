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
                text: peerprofile.title
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
                    width: parent.width
                    visible: peerprofile.hasPhoneNumber && peerprofile.hasUsername

                    SectionHeader {
                        text: qsTr("Info")
                    }

                    Label {
                        id: phonenum
                        x: Theme.paddingLarge
                        font.pixelSize: coldata.fontSize
                        color: Theme.primaryColor
                        text: qsTr("Phone number: +%1").arg(peerprofile.phoneNumber)
                        visible: peerprofile.hasPhoneNumber
                    }

                    Label {
                        id: username
                        x: Theme.paddingLarge
                        font.pixelSize: coldata.fontSize
                        color: Theme.primaryColor
                        text: qsTr("Username: @%1").arg(peerprofile.username)
                        visible: peerprofile.hasUsername
                    }
                }

                Column {
                    id: colsettings
                    width: parent.width

                    SectionHeader {
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
