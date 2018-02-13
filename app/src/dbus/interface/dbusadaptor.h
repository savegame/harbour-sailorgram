#ifndef DBUSADAPTOR_H
#define DBUSADAPTOR_H

#include <QDBusAbstractAdaptor>
#include <QDebug>
#include "../../defines.h"

class DBusAdaptor : public QDBusAbstractAdaptor
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", DBUS_INTERFACE)

    public:
        explicit DBusAdaptor(QObject *parent = 0);

    public slots:
        void wakeUp();
        void openDialog(qint32 dialogid);
};

#endif // DBUSADAPTOR_H
