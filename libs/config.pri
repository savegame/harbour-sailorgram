INSTALL_LIB_DIR = /usr/share/harbour-telega/lib

QMAKE_RPATHDIR += $$INSTALL_LIB_DIR

libqtelegram {
    LIBQTELEGRAM_DIR = libs/LibQTelegram
    LIBS += -lQTelegram
    INCLUDEPATH += $$TOP_SOURCE_DIR/$$LIBQTELEGRAM_DIR

    libqtelegram.files = $$TOP_BUILD_DIR/$$LIBQTELEGRAM_DIR/libQTelegram.so.*
    libqtelegram.path = $$INSTALL_LIB_DIR
    INSTALLS += libqtelegram
}
