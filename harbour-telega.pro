TEMPLATE = subdirs

libqtelegram.file = LibQTelegram/LibQTelegram.pro

app.depends = libqtelegram

SUBDIRS += libqtelegram app

OTHER_FILES += \
    rpm/harbour-telega.changes \
    rpm/harbour-telega.yaml
