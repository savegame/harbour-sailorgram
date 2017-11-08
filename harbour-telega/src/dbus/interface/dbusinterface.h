#ifndef DBUSINTERFACE_H
#define DBUSINTERFACE_H

#include <QtDBus>
#include "dbusadaptor.h"

class DBusInterface : public QObject
{
    Q_OBJECT

    public:
        explicit DBusInterface(QObject *parent = 0);

    public:
        static void sendWakeUp();

    public slots:
        void wakeUp();
        void openDialog(qint32 dialogid);

    signals:
        void wakeUpRequested();
        void openDialogRequested(qint32 dialogid);
};

#endif // DBUSINTERFACE_H
