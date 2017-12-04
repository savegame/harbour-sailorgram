import QtQuick 2.1
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "../../custom"

Item
{
    property alias source: mediaplayer.source

    id: animatedmessage

    MediaPlayer {
        id: mediaplayer;
        autoPlay: false;
        autoLoad: false;
        loops: MediaPlayer.Infinite
    }
    VideoOutput { anchors.fill: parent; source: mediaplayer }
    BusyIndicator { size: BusyIndicatorSize.Small; anchors.centerIn: parent; running: mediamessageitem.downloading }

    BlurredImage
    {
        id: thumb
        anchors.fill: parent
        source: mediamessageitem.thumbnail
        showActions: false
        visible: (mediaplayer.playbackState !== MediaPlayer.PlayingState) && mediamessageitem.downloaded
    }

    Image {
        id: playBtn
        source: "image://theme/icon-m-play"
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        width: parent.width * 0.4
        height: parent.height * 0.4
        visible: (mediaplayer.playbackState !== MediaPlayer.PlayingState) && mediamessageitem.downloaded
    }

    MouseArea
    {
        anchors.fill: parent
        enabled: !messageslist.selectionMode

        onClicked: {
            if(mediamessageitem.downloaded) {
                if(mediaplayer.playbackState !== MediaPlayer.PlayingState)
                {
                    mediaplayer.play();
                    thumb.visible = false;
                    playBtn.visible = false;
                }
                else
                {
                    mediaplayer.stop();
                    thumb.visible = true;
                    playBtn.visible = true;
                }
                return;
            }

            mediamessageitem.download();
        }
    }
}
