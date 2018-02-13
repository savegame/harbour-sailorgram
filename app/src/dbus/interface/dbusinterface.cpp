#include "dbusinterface.h"
#include "../../defines.h"

DBusInterface::DBusInterface(QObject *parent) : QObject(parent)
{
    new DBusAdaptor(this);

    QDBusConnection connection = QDBusConnection::sessionBus();

    if(!connection.isConnected())
    {
        qWarning("Cannot connect to the D-Bus session bus.");
        return;
    }

    if(!connection.registerService(DBUS_INTERFACE))
    {
        qWarning() << connection.lastError().message();
        return;
    }

    if(!connection.registerObject("/", this))
        qWarning() << connection.lastError().message();
}

void DBusInterface::sendWakeUp()
{
    QDBusMessage message = QDBusMessage::createMethodCall(DBUS_INTERFACE, "/", DBUS_INTERFACE, "wakeUp");
    QDBusConnection connection = QDBusConnection::sessionBus();
    connection.send(message);
}

void DBusInterface::wakeUp()
{
    emit wakeUpRequested();
}

void DBusInterface::openDialog(qint32 dialogid)
{
    emit openDialogRequested(dialogid);
}
