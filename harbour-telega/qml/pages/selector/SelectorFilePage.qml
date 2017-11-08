import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.telega.FilesModel 1.0
import harbour.telega.Core 1.0
import "../../model"

Dialog
{
    property Context context
    property var selectedFiles: []
    readonly property string rootPathLimit : "/"

    signal fileSelected(string file)

    id: selectorfilespage
    allowedOrientations: defaultAllowedOrientations
    acceptDestinationAction: PageStackAction.Pop
    canAccept: selectedFiles.length > 0
    onAccepted: selectedFiles.forEach(function (element) { fileSelected(element); })

    FilesModel
    {
        id: filesmodel
        folder: "HomeFolder"
        directoriesFirst: true
        sortOrder: Qt.AscendingOrder
        sortRole: FilesModel.NameRole
        filter: FilesModel.NoFilter
    }

    SilicaFlickable
    {
        anchors.fill: parent

        PullDownMenu
        {
            MenuItem
            {
                text: qsTr("Android storage")
                visible: context.core.androidStorage.length > 0

                onClicked: {
                    filesmodel.folder = context.core.androidStorage;
                }
            }

            MenuItem {
                text: qsTr("SD Card")
                visible: context.core.sdcardFolder.length > 0

                onClicked: {
                    filesmodel.folder = context.core.sdcardFolder;
                }
            }

            MenuItem {
                text: qsTr("Home")

                onClicked: {
                    filesmodel.folder = context.core.homeFolder;
                }
            }
        }

        DialogHeader
        {
            id: header
            acceptText: selectedFiles.length ? qsTr("Send %n file(s)", "", selectedFiles.length) :
                                               qsTr("Select files")
            title: filesmodel.folder
        }

        Button
        {
            id: btnparent
            text: qsTr("Back")
            visible: (filesmodel.folder !== rootPathLimit)
            anchors { left: parent.left; top: header.bottom; right: parent.right; margins: Theme.paddingMedium }

            onClicked: {
                filesmodel.folder = filesmodel.parentFolder;
            }
        }

        SilicaListView
        {
            id: lvfiles
            clip: true
            quickScroll: true
            model: filesmodel
            anchors { top: btnparent.bottom; left: parent.left; right: parent.right; bottom: parent.bottom }

            delegate: ListItem {
                property bool isSelected: (selectedFiles.indexOf(model.url) > -1)

                contentHeight: Theme.itemSizeSmall
                anchors { left: parent.left; right: parent.right }
                highlighted: isSelected

                onClicked: {
                    if (model.isDir)
                        filesmodel.folder = model.path;
                    else
                        //selectedFiles needs to be reassigned every time it is manipulated because it doesn't emit signals otherwise
                        if (isSelected) {
                            selectedFiles = selectedFiles.filter(function (element) { return element !== model.url; });
                        } else {
                            selectedFiles = selectedFiles.concat([model.url]);
                        }
                }

                Image {
                    id: imgfilefolder
                    source: model.icon
                    anchors { left: parent.left; margins: Theme.paddingMedium; verticalCenter: parent.verticalCenter }
                }

                Label {
                    text: (model.name || "")
                    elide: Text.ElideMiddle
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    maximumLineCount: 2
                    font.family: Theme.fontFamilyHeading
                    font.bold: isSelected
                    color: isSelected ? Theme.highlightColor : Theme.primaryColor
                    anchors { left: imgfilefolder.right; right: parent.right; margins: Theme.paddingMedium; verticalCenter: parent.verticalCenter }
                }
            }
        }
    }
}
