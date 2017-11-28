import QtQuick 2.1
import Sailfish.Silica 1.0

Column
{
    id: locationmessage
    width: imgmap.width

    property alias source: imgmap.source
    property alias imageWidth: imgmap.width
    property alias imageHeight: imgmap.height
    property alias color: txtvenue.color
    property string title
    property string address

    Label {
        id: txtvenue
        width: parent.width
        wrapMode: Text.Wrap
        font.pixelSize: Theme.fontSizeExtraSmall
        visible: (title.length > 0) || (address.length > 0)

        text: {
            if(address.length > 0)
                return title + "\n" + address;

            return title;
        }
    }

    Image {
        id: imgmap
        asynchronous: true
        fillMode: Image.PreserveAspectFit

        Rectangle {
            id: mapmarker
            anchors.centerIn: imgmap
            width: 10
            height: 10
            color: "red"
            rotation: 45
        }

        Label {
            id: openstreetmaplabel
            anchors {
                margins: Theme.paddingSmall
                bottom: parent.bottom
                right: parent.right
            }
            font.pixelSize: Theme.fontSizeExtraSmall
            color: "gray"
            text: "© OpenStreetMap contributors"
        }

        MouseArea {
            anchors.fill: parent
            enabled: !messageslist.selectionMode

            onClicked: {
                messagepopup.popup(qsTr("Opening location"));
                var point = mediamessageitem.geoPoint;
                var zoom = 14;
                var url = "http://www.openstreetmap.org/#map=%1/%2/%3".arg(zoom)
                                                                      .arg(point.latitude)
                                                                      .arg(point.longitude)
                Qt.openUrlExternally(url)
            }
        }
    }
}
