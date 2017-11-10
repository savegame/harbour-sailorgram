import QtQuick 2.1
import Sailfish.Silica 1.0
import "../../model"
import "../../components/custom"

Page
{
    property Context context

    id: settingspage

    SilicaFlickable
    {
        anchors.fill: parent
        contentHeight: content.height

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader { title: qsTr("Settings") }

            Button
            {
                width: parent.width * 0.7
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Chats")
                onClicked: pageStack.push(Qt.resolvedUrl("ChatSettingsPage.qml"),
                                          { "context": settingspage.context })
            }

            Button
            {
                width: parent.width * 0.7
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("about/AboutPage.qml"),
                                          { "context": settingspage.context })
            }
        }
    }
}
