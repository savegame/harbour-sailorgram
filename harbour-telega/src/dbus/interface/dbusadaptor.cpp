#include "dbusadaptor.h"

DBusAdaptor::DBusAdaptor(QObject *parent) : QDBusAbstractAdaptor(parent)
{

}

void DBusAdaptor::wakeUp()
{
    QMetaObject::invokeMethod(parent(), "wakeUp");
}

void DBusAdaptor::openDialog(qint32 dialogid)
{
    QMetaObject::invokeMethod(parent(), "openDialog", Q_ARG(qint32, dialogid));
}
