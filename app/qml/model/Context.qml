import QtQuick 2.1
import QtPositioning 5.2
import Sailfish.Silica 1.0
import harbour.telega.LibQTelegram 1.0
import harbour.telega.Core 1.0
import "../js/Settings.js" as Settings

Item
{
    readonly property bool reconnecting: reconnectTimer.running

    readonly property int bubbleradius: {
        if(context.angledbubbles)
            return 20;

        if(!context.bubbleshidden)
            return 4;

        return 0;
    }

    property bool bubbleshidden: false
    property bool angledbubbles: false
    property bool sendwithreturn: false
    property bool chatheaderhidden: false
    property bool autoloadimages:false
    property bool showsearchfield: false
    property bool defaultemojiset: false
    property real bubblesopacity: 100.0

    property Page mainPage: null
    property var lastDialog: null
    property int reconnectSeconds: 0

    property Timer reconnectTimer: Timer {
        interval: 1000
        repeat: true

        onTriggered: {
            reconnectSeconds--;
        }
    }

    property PositionSource positionSource: PositionSource {
        id: positionsource
        preferredPositioningMethods: PositionSource.AllPositioningMethods
    }

    property Telegram telegram: Telegram {
        autoDownload: context.autoloadimages

        initializer: TelegramInitializer {
            debugMode: true
            apiId: core.apiId
            apiHash: core.apiHash
            host: core.hostIp
            port: core.hostPort
            dcId: core.dcId
            publicKey: core.publicKey
        }

        onConnectedChanged: {
            if(!telegram.connected)
                return;

            reconnectTimer.stop();
        }

        onConnectionTimeout: {
            context.reconnectSeconds = seconds;
            reconnectTimer.start();
        }

        onLoginCompleted: Settings.set("phonenumber", initializer.phoneNumber);
    }

    property Core core: Core {
        telegram: context.telegram

        onOpenDialogRequested: {
            var dialog = context.dialogs.getDialog(dialogid);

            if(!dialog)
                return;

            openDialog(dialog, true);
        }
    }

    property DialogsModel dialogs: DialogsModel {
        telegram: context.telegram
    }

    function versionString() {
        var ver = core.version;
        return ver + " (LAYER " + context.telegram.apiLayer + ")";
    }

    function openDialog(dialog, immediate) {
        if(pageStack.depth > 1)
            pageStack.pop(context.mainPage, PageStackAction.Immediate);

        if(dialog !== context.lastDialog) {
            context.lastDialog = dialog;
            pageStack.pushAttached(Qt.resolvedUrl("../pages/dialog/DialogPage.qml"), { context: context, dialog: dialog, firstLoad: true });
        }

        pageStack.navigateForward((immediate === true) ? PageStackAction.Immediate : PageStackAction.Animated);

         if((immediate === true) && (Qt.application.state !== Qt.ApplicationActive))
             mainwindow.activate();
    }

    function locationThumbnail(latitude, longitude, width, height, z) {
        return "https://maps.nlp.nokia.com/mia/1.6/mapview?" + "app_id=" + core.hereAppId + "&"
                                                             + "app_code=" + core.hereAppCode + "&"
                                                             + "nord&f=0&poithm=1&poilbl=0&"
                                                             + "ctr=" + latitude + "," + longitude + "&"
                                                             + "w=" + width + "&h=" + height + "&z=" + z;
    }

    id: context

    Component.onCompleted: {
        Settings.load(function(tx) {
            context.sendwithreturn = parseInt(Settings.transactionGet(tx, "sendwithreturn"));
            context.chatheaderhidden = parseInt(Settings.transactionGet(tx, "chatheaderhidden"));
            context.autoloadimages = parseInt(Settings.transactionGet(tx, "autoloadimages"));
            context.bubbleshidden = parseInt(Settings.transactionGet(tx, "hidebubbles"));
            context.angledbubbles = parseInt(Settings.transactionGet(tx, "angledbubbles"));
            context.showsearchfield = parseInt(Settings.transactionGet(tx, "showsearchfield"));
            context.defaultemojiset = parseInt(Settings.transactionGet(tx, "defaultemojiset"));
            context.core.keepRunning = parseInt(Settings.transactionGet(tx, "keeprunning"));

            var opacity = Settings.transactionGet(tx, "bubblesopacity");
            context.bubblesopacity = (opacity === false) ? 100 : parseInt(opacity);
        });
    }
}
