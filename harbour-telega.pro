TEMPLATE = subdirs

libs.file = libs/libs.pro
app.depends = libs

SUBDIRS += app libs

OTHER_FILES += \
    .qmake.conf \
    rpm/harbour-telega.changes \
    rpm/harbour-telega.yaml
