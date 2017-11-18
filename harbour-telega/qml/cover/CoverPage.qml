import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.telega.Model 1.0
import "../model"
import "../js/ColorScheme.js" as ColorScheme

CoverBackground
{
    property Context context

    id: coverpage

    Image
    {
        id: imgcover
        source: "qrc:///res/cover.png"
        asynchronous: true
        opacity: 0.1
        width: parent.width * 1.15
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
    }

    Rectangle {
        id: rectstatus
        height: Theme.itemSizeMedium
        width: height
        radius: height / 2
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        color: {
            if(context.telegram.syncing)
                return "yellow";

            if(context.telegram.connected)
                return "lime";

            return "red";
        }
        opacity: 0.5

        Label {
            id: lblunreadcount
            anchors.centerIn: rectstatus
            text: context.telegram.unreadCount
            font {
                pixelSize: Theme.fontSizeHuge
                family: Theme.fontFamilyHeading
            }
            opacity: 0.9
        }
    }

    Column
    {
        id: colmessages

        anchors {
            top: rectstatus.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            topMargin: Theme.paddingSmall
            leftMargin: Theme.paddingLarge
        }

        Repeater {
            model: DialogsCoverModel {
                dialogsModel: (context.dialogs.initializing || context.dialogs.loading) ? null : context.dialogs
                maxDialogs: 6
            }

            delegate: Label {
                width: colmessages.width
                elide: Text.ElideRight
                truncationMode: TruncationMode.Fade
                font.pixelSize: Theme.fontSizeSmall
                color: model.unreadCount > 0 ? Theme.highlightColor : Theme.primaryColor
                text: model.title
            }
        }
    }

    CoverActionList
    {
        enabled: pageStack.currentPage.isMediaPage !== true

        CoverAction
        {
            iconSource: "image://theme/icon-cover-message"

            onTriggered: {
                pageStack.push(Qt.resolvedUrl("../pages/contact/ContactsPage.qml"), { context: coverpage.context }, PageStackAction.Immediate);
                mainwindow.activate();
            }
        }

        CoverAction
        {
            iconSource: context.core.notifications.mute ? "noalarmcover.png" : "alarmcover.png"

            onTriggered: {
                context.core.notifications.mute = !context.core.notifications.mute;
            }
        }
    }
}
