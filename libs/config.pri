INSTALL_LIB_DIR = /usr/share/harbour-telega/lib

QMAKE_RPATHDIR += $$INSTALL_LIB_DIR

libqtelegram {
    LIBQTELEGRAM_DIR = libs/LibQTelegram
    LIBS += -L$$TOP_BUILD_DIR/$$LIBQTELEGRAM_DIR -lQTelegram
    INCLUDEPATH += $$TOP_SRC_DIR/$$LIBQTELEGRAM_DIR

    libqtelegram.files = $$TOP_BUILD_DIR/$$LIBQTELEGRAM_DIR/libQTelegram.so.*
    libqtelegram.path = $$INSTALL_LIB_DIR
    INSTALLS += libqtelegram
}
