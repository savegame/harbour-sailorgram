import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.telega.Model 1.0
import "../../../components/about"
import "../../../model"

Page
{
    property Context context

    id: translationspage
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

            PageHeader {
                id: pageheader
                title: qsTr("Translations")
            }

            Repeater
            {
                id: contentview
                model: context.core.translations

                delegate: Column {
                    anchors { left: parent.left; right: parent.right }
                    spacing: Theme.paddingMedium

                    Label {
                        anchors { left: parent.left; right: parent.right }
                        horizontalAlignment: Text.AlignHCenter
                        text: model.modelData.name
                        font.bold: true
                    }

                    CollaboratorsLabel {
                        title: qsTr("Coordinators");
                        labelData: model.modelData.coordinators
                    }

                    CollaboratorsLabel {
                        title: qsTr("Translators");
                        labelData: model.modelData.translators
                    }

                    CollaboratorsLabel {
                        title: qsTr("Reviewers");
                        labelData: model.modelData.reviewers
                    }
                }
            }
        }
    }
}
