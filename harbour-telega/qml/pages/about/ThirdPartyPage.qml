import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.telega.Model 1.0
import "../../components/about"

Page
{
    id: thirdpartypage
    allowedOrientations: Orientation.Portrait

    SilicaFlickable
    {
        id: flickable
        anchors.fill: parent
        contentHeight: content.height

        VerticalScrollDecorator { flickable: flickable }

        Column
        {
            id: content
            width: parent.width
            spacing: Theme.paddingLarge

            PageHeader
            {
                id: pageheader
                title: qsTr("Third Party")
            }

            ThirdPartyLabel
            {
                title:"LibQTelegram"
                copyright: qsTr("The GPLv3 license")
                licenselink: "https://raw.githubusercontent.com/QtGram/LibQTelegram/master/LICENSE"
                link: "https://github.com/QtGram/LibQTelegram"
            }

            ThirdPartyLabel
            {
                title:"Emoji One"
                copyright: qsTr("Attribution 4.0 International (CC BY 4.0)")
                licenselink: "http://emojione.com/licensing/"
                link: "http://emojione.com"
            }
        }
    }
}
