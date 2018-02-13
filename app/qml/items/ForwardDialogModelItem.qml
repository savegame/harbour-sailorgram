import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.telega.LibQTelegram 1.0
import "../components/peer"

ListItem
{
    id: forwarddialogmodelitem
    contentHeight: Theme.itemSizeSmall

    PeerImage
    {
        id: peerimage
        size: forwarddialogmodelitem.contentHeight
        peer: model.item

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            leftMargin: Theme.paddingSmall
        }
    }

    Label
    {
        anchors {
            left: peerimage.right
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            leftMargin: Theme.paddingSmall
            rightMargin: Theme.paddingSmall
        }

        wrapMode: Text.NoWrap
        elide: Text.ElideRight
        text: model.dialogTitle
        verticalAlignment: Text.AlignVCenter
    }
}
