import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.telega.LibQTelegram 1.0
import "../../components/message/input"
import "../../components/dialog"
import "../../items"
import "../../model"
import "../peer"

SilicaListView {
    id: messageslist
    cacheBuffer: Screen.height * 2
    verticalLayoutDirection: ListView.BottomToTop
    currentIndex: -1

    readonly property alias dialogInputPanel: messageslist.headerItem
    property bool selectionMode: false
    property bool positionPending: false
    property var selectedMessages: null

    function getSelectionList() {
        var selectionlist = [];

        for(var selindex in selectedMessages) {
            if(!selectedMessages.hasOwnProperty(selindex))
                continue;

            selectionlist.push(messagesmodel.get(selindex));
        }

        return selectionlist;
    }

    Component.onCompleted: {
        messageslist.positionViewAtIndex(model.newMessageIndex, ListView.Center)
    }

    onSelectionModeChanged: {
        if(selectionMode) {
            selectedMessages = new Object;
            return;
        }

        delete selectedMessages;
    }

    Connections {
        target: dialogpage.context.positionSource

        onPositionChanged: {
            if(!positionPending)
                return;

            var coord = dialogpage.context.positionSource.position.coordinate
            messagesmodel.sendLocation(coord.latitude, coord.longitude);

            positionPending = false;
        }
    }

    header: DialogInputPanel {
        width: messageslist.width
    }

    delegate: Column {
        width: parent.width
        spacing: Theme.paddingSmall

        NewMessage {
            id: newmessage
            visible: model.isMessageNew
        }

        Row {
            width: parent.width

            GlassItem {
                id: selindicator
                anchors.verticalCenter: parent.verticalCenter
                visible: selectionMode
                dimmed: !messagemodelitem.selected
            }

            MessageModelItem {
                id: messagemodelitem
                maxWidth: {
                    var w = width - 2 * Theme.paddingMedium;
                    if(!messagesmodel.isBroadcast)
                        w *= 0.9;
                    return w;
                }

                width: {
                    var w = parent.width;
                    if(selindicator.visible)
                        w -= selindicator.width;
                    return w;
                }

                onReplyRequested: {
                    dialogInputPanel.prepareReply(model);
                    messageslist.positionViewAtBeginning();
                }

                onEditRequested: {
                    dialogInputPanel.prepareEdit(model);
                    messageslist.positionViewAtBeginning();
                }
            }
        }
    }

    VerticalScrollDecorator {
        flickable: messageslist
    }
}
