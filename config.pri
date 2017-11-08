LIBQTELEGRAM_LIB_NAME = QTelegram
LIBQTELEGRAM_LIB_DIR = $$OUT_PWD/../LibQTelegram
LIBQTELEGRAM_INCLUDE_PATH = $$PWD/LibQTelegram

CONFIG += c++11

!isEqual(TARGET, "harbour-telega") {
    target = $$TARGET
    target.path = /usr/share/harbour-telega/lib
    INSTALLS += target
}
