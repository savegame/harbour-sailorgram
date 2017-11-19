import QtQuick 2.1
import Sailfish.Silica 1.0
import "../../message"
import "../../custom"

MouseArea
{
    readonly property real calculatedWidth: Math.max(wpmessage.calculatedWidth,
                                                     wptitle.calculatedWidth,
                                                     wpdescription.calculatedWidth)

    property alias messageText: wpmessage.rawText
    property alias title: wptitle.rawText
    property alias description: wpdescription.rawText
    property alias source: imgthumbnail.source
    property alias quoteColor: messagequote.color
    property color color: Theme.primaryColor
    property string destinationUrl

    id: webpagemessage
    height: content.height
    enabled: !messageslist.selectionMode

    onClicked: {
        messagepopup.popup(qsTr("Launching external web browser"));
        Qt.resolvedUrl(destinationUrl);
    }

    Column
    {
        id: content
        spacing: Theme.paddingSmall
        width: parent.width

        MessageText
        {
            id: wpmessage
            emojiPath: context.core.emojiPath
            font.pixelSize: Theme.fontSizeSmall
            color: webpagemessage.color
            linkColor: webpagemessage.quoteColor
            width: parent.width
            wrapMode: Text.Wrap
            elide: Text.ElideRight
        }

        Row
        {
            id: preview
            width: parent.width
            height: previewcontent.height
            spacing: Theme.paddingSmall

            MessageQuote { id: messagequote; height: parent.height }

            Column
            {
                id: previewcontent
                width: parent.width - (Theme.paddingSmall * 2)
                spacing: Theme.paddingMedium

                MessageText
                {
                    id: wptitle
                    emojiPath: context.core.emojiPath
                    visible: rawText.length > 0
                    color: webpagemessage.color
                    linkColor: webpagemessage.quoteColor
                    width: parent.width
                    wrapMode: Text.Wrap
                    font { bold: true; pixelSize: Theme.fontSizeSmall }
                }

                MessageText
                {
                    id: wpdescription
                    emojiPath: context.core.emojiPath
                    visible: rawText.length > 0
                    color: webpagemessage.color
                    linkColor: webpagemessage.quoteColor
                    width: parent.width
                    wrapMode: Text.Wrap
                    font { pixelSize: Theme.fontSizeExtraSmall; italic: true }
                }

                BlurredImage
                {
                    id: imgthumbnail
                    width: parent.width
                    height: mediamessageitem.webPageThumbnailHeight
                }
            }
        }
    }
}
