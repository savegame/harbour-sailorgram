import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.TelegramQml 1.0
import "../../components"
import "../../items"
import "../../items/messageitem"
import "../../js/TelegramHelper.js" as TelegramHelper

Page
{
    property Telegram telegram
    property Dialog dialog
    property int peerId: dialog.peer.chatId !== 0 ? dialog.peer.chatId : dialog.peer.userId
    property bool muted: telegram.userData.isMuted(peerId)

    id: conversationpage

    Component.onCompleted: {
        messagemodel.clearNewMessageFlag();
        messagemodel.setReaded();
    }

    RemorsePopup { id: remorsepopup }

    PopupMessage
    {
        id: popupmessage
        anchors { left: parent.left; top: parent.top; right: parent.right }
    }

    Connections
    {
        target: telegram.userData

        onMuteChanged: {
            if(id !== conversationpage.peerId)
                return;

            conversationpage.muted = telegram.userData.isMuted(conversationpage.peerId);
        }
    }

    SilicaFlickable
    {
        id: flickable
        anchors.fill: parent

        PullDownMenu
        {
            id: menu

            MenuItem {
                text: conversationpage.muted ? qsTr("Enable Notifications") : qsTr("Disable Notifications")

                onClicked: {
                    if(conversationpage.muted)
                        telegram.userData.removeMute(conversationpage.peerId)
                    else
                        telegram.userData.addMute(conversationpage.peerId)
                }
            }

            MenuItem {
                text: qsTr("Delete")

                onClicked: {
                    remorsepopup.execute(qsTr("Deleting History"), function() {
                        telegram.messagesDeleteHistory(item.peer.userId);
                        pageStack.pop();
                    });
                }
            }
        }

        ContactItem
        {
            id: header
            anchors { left: parent.left; top: parent.top; right: parent.right; leftMargin: Theme.horizontalPageMargin; topMargin: Theme.paddingMedium }
            height: Theme.itemSizeSmall
            telegram: conversationpage.telegram
            user: telegram.user(dialog.peer.userId)
        }

        SilicaListView
        {
            id: lvdialog
            anchors { left: parent.left; top: header.bottom; right: parent.right; bottom: messagebar.top }
            verticalLayoutDirection: ListView.BottomToTop
            spacing: Theme.paddingMedium
            clip: true

            model: MessagesModel {
                id: messagemodel
                telegram: conversationpage.telegram
                dialog: conversationpage.dialog

                onMessageAdded: { /* We are in this chat, always mark these messages as read */
                    messagemodel.clearNewMessageFlag();
                    messagemodel.setReaded();
                }
            }

            delegate: MessageItem {
                telegram: conversationpage.telegram
                message: item
            }
        }

        MessageBar
        {
            id: messagebar
            anchors { left: parent.left; bottom: parent.bottom; right: parent.right }
        }
    }
}
