TEMPLATE = subdirs

libqtelegram.file = LibQTelegram/LibQTelegram.pro

harbour-telega.depends = libqtelegram

SUBDIRS += libqtelegram harbour-telega
