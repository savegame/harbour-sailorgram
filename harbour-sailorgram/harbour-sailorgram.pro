# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-sailorgram

include($$PWD/../config.pri)

DEFINES += APP_VERSION=\\\"$$APP_VERSION\\\"

CONFIG += sailfishapp
QT     += sql dbus multimedia

LIBS += -L$$LIBQTELEGRAM_LIB_DIR -lQTelegram
INCLUDEPATH += $$LIBQTELEGRAM_INCLUDE_PATH

# LibQTelegram
libqtelegram.files = $$OUT_PWD/../LibQTelegram/libQTelegram.so*
libqtelegram.path  = /usr/share/$$TARGET/lib
INSTALLS += libqtelegram

# WebP Plugin
webp.files = $$OUT_PWD/../webp-plugin/plugins/imageformats/*.so
webp.path  = /usr/share/$$TARGET/lib/imageformats/
INSTALLS += webp

# Telegram Public Key
public_key.files = $$PWD/public.key
public_key.path  = /usr/share/$$TARGET
INSTALLS    += public_key
OTHER_FILES += $$public_key.files

# Emoji Set
emoji.files = $$PWD/res/emoji/*.png
emoji.path  = /usr/share/$$TARGET/emoji
INSTALLS += emoji

# Lipstick Config
lipstick_config.files = $$PWD/lipstick/*.conf
lipstick_config.path  = /usr/share/lipstick/notificationcategories
INSTALLS    += lipstick_config
OTHER_FILES += $$lipstick_config.files

# DBus Config
dbus_config.files = $$PWD/dbus/*.service
dbus_config.path  = /usr/share/dbus-1/services
INSTALLS    += dbus_config
OTHER_FILES += $$dbus_config.files

# Systemd Config
systemd.files = $$PWD/systemd/*.service
systemd.path  = /usr/lib/systemd/user
INSTALLS    += systemd
OTHER_FILES += $$systemd.files

# Events Config
events.files = $$PWD/events/*.ini
events.path  = /usr/share/ngfd/events.d
INSTALLS    += events
OTHER_FILES += $$events.files

# MCE Config
mce.files = $$PWD/mce/*.ini
mce.path  = /etc/mce
INSTALLS    += mce
OTHER_FILES += $$mce.files

# Headers
HEADERS += \
    src/sailorgram.h \
    src/dbus/screenblank.h \
    src/dbus/interface/sailorgramadaptor.h \
    src/dbus/interface/sailorgraminterface.h \
    src/dbus/notification/notification.h \
    src/dbus/notification/notificationmanagerproxy.h \
    src/selector/audiorecorder.h \
    src/selector/thumbnailprovider.h \
    src/selector/exif/exif.h \
    src/selector/filesmodel.h \
    src/selector/filesmodelworker.h \
    src/item/translationinfoitem.h \
    src/model/dialogscovermodel.h

# Sources
SOURCES += \
    src/harbour-sailorgram.cpp \
    src/sailorgram.cpp \
    src/dbus/screenblank.cpp \
    src/dbus/interface/sailorgramadaptor.cpp \
    src/dbus/interface/sailorgraminterface.cpp \
    src/dbus/notification/notification.cpp \
    src/dbus/notification/notificationmanagerproxy.cpp \
    src/selector/audiorecorder.cpp \
    src/selector/thumbnailprovider.cpp \
    src/selector/exif/exif.cpp \
    src/selector/filesmodel.cpp \
    src/selector/filesmodelworker.cpp \
    src/item/translationinfoitem.cpp \
    src/model/dialogscovermodel.cpp

# QML
OTHER_FILES += \
    qml/js/*.js \
    qml/harbour-sailorgram.qml \
    qml/items/message/ForwardItem.qml \
    qml/items/sticker/StickerCategory.qml \
    qml/model/Context.qml \
    qml/js/CountryList.js \
    qml/js/Emoji.js \
    qml/js/Settings.js \
    qml/js/TextElaborator.js \
    qml/pages/MainPage.qml \
    qml/components/login/PhoneNumber.qml \
    qml/components/login/SignIn.qml \
    qml/components/login/SignUp.qml \
    qml/components/dialog/DialogsList.qml \
    qml/items/DialogModelItem.qml \
    qml/components/message/MessageStatus.qml \
    qml/components/message/MessageText.qml \
    qml/pages/contact/ContactsPage.qml \
    qml/items/ContactModelItem.qml \
    qml/components/contact/ContactsList.qml \
    qml/cover/CoverPage.qml \
    qml/js/ColorScheme.js

# Translations
CONFIG += sailfishapp_i18n

OTHER_FILES += \
    translations/*.ts \
    update_translations_json.sh

TRANSLATIONS += \
    translations/harbour-sailorgram-be.ts \
    translations/harbour-sailorgram-cs.ts \
    translations/harbour-sailorgram-da.ts \
    translations/harbour-sailorgram-de.ts \
    translations/harbour-sailorgram-de_DE.ts \
    translations/harbour-sailorgram-el.ts \
    translations/harbour-sailorgram-es.ts \
    translations/harbour-sailorgram-fa_IR.ts \
    translations/harbour-sailorgram-fi.ts \
    translations/harbour-sailorgram-fr.ts \
    translations/harbour-sailorgram-gl.ts \
    translations/harbour-sailorgram-it.ts \
    translations/harbour-sailorgram-nl_NL.ts \
    translations/harbour-sailorgram-ru.ts \
    translations/harbour-sailorgram-sv.ts \
    translations/harbour-sailorgram-uk_UA.ts \
    translations/harbour-sailorgram.ts

# Resources
RESOURCES += \
    resources.qrc

# Packaging
SAILFISHAPP_ICONS = \
    86x86 \
    108x108 \
    128x128

OTHER_FILES += \
    rpm/harbour-sailorgram.changes \
    rpm/harbour-sailorgram.spec \
    harbour-sailorgram.desktop \
    qml/cover/*.png

DISTFILES += \
    qml/components/about/CollaboratorsLabel.qml \
    qml/components/about/ThirdPartyLabel.qml \
    qml/pages/dialog/DialogPage.qml \
    qml/components/dialog/DialogTopHeader.qml \
    qml/components/custom/BackgroundRectangle.qml \
    qml/components/message/MessagesList.qml \
    qml/items/MessageModelItem.qml \
    qml/components/message/MessageBubble.qml \
    qml/components/message/media/ImageMessage.qml \
    qml/components/message/media/AnimatedMessage.qml \
    qml/components/message/media/LocationMessage.qml \
    qml/components/message/media/FileMessage.qml \
    qml/components/message/media/WebPageMessage.qml \
    qml/pages/settings/SettingsPage.qml \
    qml/pages/settings/about/AboutPage.qml \
    qml/pages/settings/about/DevelopersPage.qml \
    qml/pages/settings/about/ThirdPartyPage.qml \
    qml/pages/settings/about/TranslationsPage.qml \
    qml/pages/settings/ChatSettingsPage.qml \
    qml/pages/settings/DaemonSettingsPage.qml \
    qml/components/message/NewMessage.qml \
    qml/components/message/MessageQuote.qml \
    qml/components/message/input/MessageTextInput.qml \
    qml/components/message/panel/MessagePanel.qml \
    qml/components/message/panel/MessagePanelItem.qml \
    qml/components/login/TwoFactor.qml \
    qml/menu/DialogModelItemMenu.qml \
    qml/menu/MessageModelItemMenu.qml \
    qml/components/message/media/AudioMessage.qml \
    qml/components/custom/ClickableLabel.qml \
    qml/pages/dialog/chat/NewChannelPage.qml \
    qml/pages/dialog/chat/NewChatPage.qml \
    qml/pages/dialog/chat/NewGroupPage.qml \
    qml/components/dialog/DialogNotificationSwitch.qml \
    qml/components/dialog/DialogMediaPanel.qml \
    qml/pages/selector/SelectorImagePage.qml \
    qml/pages/selector/SelectorFilePage.qml \
    qml/pages/media/ImageViewerPage.qml \
    qml/pages/dialog/DetailsPage.qml \
    qml/components/custom/ProgressIndicator.qml \
    qml/components/custom/ConnectionStatus.qml \
    qml/components/custom/MessagePopup.qml \
    qml/components/mediaplayer/mediacomponents/MediaPlayerCursor.qml \
    qml/components/mediaplayer/mediacomponents/MediaPlayerError.qml \
    qml/components/mediaplayer/mediacomponents/MediaPlayerPopup.qml \
    qml/components/mediaplayer/mediacomponents/MediaPlayerProgressBar.qml \
    qml/components/mediaplayer/mediacomponents/MediaPlayerTitle.qml \
    qml/components/mediaplayer/mediacomponents/MediaPlayerToolBar.qml \
    qml/js/MediaPlayerHelper.js \
    qml/components/mediaplayer/mediacomponents/MediaPlayerLoadingBar.qml \
    qml/pages/media/MediaPlayerPage.qml \
    qml/components/mediaplayer/InternalMediaPlayer.qml \
    qml/pages/dialog/ForwardPage.qml \
    qml/items/ForwardDialogModelItem.qml \
    qml/components/dialog/DialogInputPanel.qml \
    qml/components/message/input/MessageInputPreview.qml \
    qml/components/peer/PeerImage.qml \
    qml/components/custom/BlurredImage.qml \
    qml/components/message/preview/MessagePreviewImage.qml \
    qml/components/message/preview/MessagePreviewItem.qml \
    qml/components/message/media/StickerMessage.qml \
    qml/pages/media/ImageSendPage.qml
