import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.telega.LibQTelegram 1.0
import "../components/message/preview"
import "../components/message/media"
import "../components/message"
import "../components/custom"
import "../menu"
import "../js/ColorScheme.js" as ColorScheme

ListItem
{
    id: messagemodelitem

    readonly property color bubbleColor: {
        var c = ColorScheme.colorizeBubble(model.isMessageService, model.isMessageOut, context)

        if(down)
            return Qt.darker(c, 1.5);

        return c;
    }

    readonly property color textColor: ColorScheme.colorizeText(model.isMessageService, model.isMessageOut, context)
    readonly property color linkColor: ColorScheme.colorizeLink(model.isMessageService, model.isMessageOut, context)
    readonly property color quoteColor: linkColor
    readonly property int padding: Theme.paddingMedium

    property bool selected: false
    property real maxWidth

    signal replyRequested()
    signal editRequested()

    contentHeight: content.height + 2 * padding

    _backgroundColor: {
        if(context.bubbleshidden)
            return _showPress ? highlightedColor : "transparent";

        return "transparent";
    }

    onClicked: {
        if(!messageslist.selectionMode)
            return;

        if(messageslist.selectedMessages[model.index] === true) {
            delete messageslist.selectedMessages[model.index];
            messagemodelitem.selected = false;
            return;
        }

        messageslist.selectedMessages[model.index] = true;
        messagemodelitem.selected = true;
    }

    menu: MessageModelItemMenu {
        enabled: !messageslist.selectionMode
    }

    MessageBubble {
        width: content.width + messagemodelitem.padding
        height: content.height + messagemodelitem.padding
        anchors.centerIn: content

        visible: {
            if(context.bubbleshidden)
                return false;

            return !model.isMessageService;
        }
    }

    Column {
        id: content

        width: {
            if(model.isMessageService)
                return parent.width;

            var w = Math.max(lblfrom.calculatedWidth,
                             lblmessage.calculatedWidth,
                             messagereplyitem.calculatedWidth,
                             mediamessageitem.contentWidth,
                             messagestatus.contentWidth);

            return Math.min(w, maxWidth);
        }

        anchors {
            top: parent.top
            leftMargin: messagemodelitem.padding
            rightMargin: messagemodelitem.padding

            left: {
                if(model.isMessageService)
                    return parent.left;

                return model.isMessageOut ? undefined : parent.left;
            }

            right: {
                if(model.isMessageService)
                    return parent.right;

                return !model.isMessageOut ? undefined : parent.right;
            }
        }

        MessageText {
            id: lblfrom
            width: parent.width
            emojiPath: context.core.emojiPath
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignLeft
            font {
                bold: true
                pixelSize: Theme.fontSizeSmall
            }
            color: messagemodelitem.textColor
            linkColor: messagemodelitem.linkColor
            rawText: model.isMessageForwarded ? qsTr("Forwarded from %1").arg(model.forwardedFromName) : model.messageFrom
            visible: !model.isMessageService
            openUrls: !messageslist.selectionMode
        }

        MessagePreviewItem {
            id: messagereplyitem
            width: parent.width
            quoteColor: messagemodelitem.quoteColor
            color: messagemodelitem.textColor
            visible: model.messageHasReply
            message: model.messageHasReply ? model.replyItem : null
            previewFrom: model.replyFrom

            previewText: {
                if(!model.messageHasReply)
                    return "";

                if(model.replyCaption.length <= 0)
                    return model.replyText;

                return model.replyCaption;
            }
        }

        MediaMessageItem {
            id: mediamessageitem
            message: model.item
            size: parent.width

            imageDelegate: ImageMessage {
                anchors.fill: parent
                source: mediamessageitem.isVideo ? mediamessageitem.videoThumbnail : mediamessageitem.source
            }

            stickerDelegate: StickerMessage {
                anchors.fill: parent
                source: mediamessageitem.downloaded ? mediamessageitem.source : mediamessageitem.thumbnail
            }

            animatedDelegate: AnimatedMessage {
                anchors.fill: parent
                source: mediamessageitem.source
            }

            locationDelegate: LocationMessage {
                title: mediamessageitem.venueTitle
                address: mediamessageitem.venueAddress
                color: messagemodelitem.textColor

                source: {
                    return context.locationThumbnail(mediamessageitem.geoPoint.latitude,
                                                     mediamessageitem.geoPoint.longitude,
                                                     maxWidth, maxWidth, 14)
                }
            }

            webPageDelegate: WebPageMessage {
                width: Math.min(calculatedWidth, maxWidth)
                color: messagemodelitem.textColor
                quoteColor: messagemodelitem.linkColor
                title: mediamessageitem.webPageTitle
                description: mediamessageitem.webPageDescription
                destinationUrl: mediamessageitem.webPageUrl
                source: mediamessageitem.source
                messageText: model.messageText
            }

            audioDelegate: AudioMessage {
                width: Math.min(contentWidth, maxWidth)
                duration: mediamessageitem.duration
                color: messagemodelitem.textColor
                barColor: messagemodelitem.linkColor
                source: mediamessageitem.source
                message: model.item
            }

            fileDelegate: FileMessage {
                width: Math.min(contentWidth, maxWidth)
                fileName: mediamessageitem.fileName
                fileSize: mediamessageitem.fileSize
            }
        }

        MessageText {
            id: lblmessage
            width: parent.width
            emojiPath: context.core.emojiPath
            wrapMode: Text.Wrap
            font {
                italic: model.isMessageService
                pixelSize: model.isMessageService ? Theme.fontSizeExtraSmall : Theme.fontSizeSmall
            }
            color: messagemodelitem.textColor
            linkColor: messagemodelitem.linkColor
            openUrls: !messageslist.selectionMode
            visible: rawText.length > 0

            rawText: {
                if(model.isMessageMedia)
                    return model.messageCaption;

                return model.messageText;
            }

            horizontalAlignment: {
                if(model.isMessageService)
                    return Text.AlignHCenter;

                return Text.AlignLeft;
            }
        }

        MessageStatus {
            id: messagestatus
            font.pixelSize: Theme.fontSizeTiny
            width: parent.width
            visible: !model.isMessageService
            horizontalAlignment: model.isMessageOut ? Text.AlignRight : Text.AlignLeft
            isMessageOut: model.isMessageOut
            isMessageUnread: model.isMessageUnread
            isMessageEdited: model.isMessageEdited
            isMessagePending: model.isMessagePending
            messageDate: model.messageDate
            color: messagemodelitem.textColor
            ticksColor: messagestatus.color
        }
    }
}
