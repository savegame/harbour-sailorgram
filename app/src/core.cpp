#include "core.h"
#include <config/telegramconfig.h>
#include <types/telegramhelper.h>
#include "defines.h"

Core::Core(QObject *parent) :
    QObject(parent),
    _telegram(nullptr)
{
    this->_interface = new DBusInterface(this);
    this->_notifications = new TelegramNotifications(this);

    connect(this->_notifications, &TelegramNotifications::newMessage, this, &Core::notify);
    connect(this->_interface, &DBusInterface::wakeUpRequested, this, &Core::onWakeUpRequested);
    connect(this->_interface, &DBusInterface::openDialogRequested, this, &Core::openDialogRequested);
}

Telegram *Core::telegram() const
{
    return this->_telegram;
}

QString Core::version() const
{
    return qApp->applicationVersion();
}

int Core::apiId() const
{
    return TELEGRAM_API_ID;
}

QString Core::apiHash() const
{
    return TELEGRAM_API_HASH;
}

QString Core::hostIp() const
{
    return TELEGRAM_HOST_IP;
}

int Core::hostPort() const
{
    return TELEGRAM_HOST_PORT;
}

int Core::dcId() const
{
    return TELEGRAM_DC_ID;
}

bool Core::keepRunning() const
{
    return !qApp->quitOnLastWindowClosed();
}

QString Core::emojiPath() const
{
    return QString("%1/../share/%2/%3/").arg(qApp->applicationDirPath())
                                        .arg(APP_NAME)
                                        .arg(EMOJI_FOLDER);
}

QString Core::publicKey() const
{
    return QString("%1/../share/%2/%3").arg(qApp->applicationDirPath())
                                        .arg(APP_NAME)
                                        .arg(TELEGRAM_PUBLIC_KEY_FILE);
}

QString Core::homeFolder() const
{
    return QStandardPaths::writableLocation(QStandardPaths::HomeLocation);
}

QString Core::sdcardFolder() const
{
    QString sdcardfolder;

    if(QFile::exists("/media/sdcard"))
        sdcardfolder = "/media/sdcard";

    if(QFile::exists("/run/user/100000/media/sdcard"))
        sdcardfolder = "/run/user/100000/media/sdcard";

    if(sdcardfolder.isEmpty())
        return QString();

    QDir dir(sdcardfolder);
    QFileInfoList fileinfolist = dir.entryInfoList(QDir::AllDirs | QDir::Files | QDir::NoDotAndDotDot | QDir::NoSymLinks, QDir::DirsFirst | QDir::Time);

    if(fileinfolist.isEmpty())
        return QString();

    return fileinfolist.first().filePath();
}

QString Core::picturesFolder() const
{
    return QStandardPaths::writableLocation(QStandardPaths::PicturesLocation);
}

QString Core::androidStorage() const
{
    QDir homefolder(this->homeFolder());

    if(!homefolder.exists("android_storage"))
        return QString();

    return homefolder.absoluteFilePath("android_storage");
}

QString Core::voiceRecordPath() const
{
    QDir cachefolder = QStandardPaths::writableLocation(QStandardPaths::CacheLocation);
    return cachefolder.absoluteFilePath("voice-rec.ogg");
}

TelegramNotifications *Core::notifications() const
{
    return this->_notifications;
}

QList<QObject *> Core::translations() const
{
    QList<QObject *> trlist;
    QFile jsonfile(":/translations/translations.json");
    if (jsonfile.open(QFile::ReadOnly))
    {
        QJsonParseError error;
        QJsonDocument json = QJsonDocument::fromJson(jsonfile.readAll(), &error);
        if (error.error != QJsonParseError::NoError)
            return trlist;
        foreach (QJsonValue jsonarrayvalue, json.array())
            trlist.append(new TranslationInfoItem(jsonarrayvalue.toObject()));
    }
    return trlist;
}

void Core::setTelegram(Telegram *telegram)
{
    if(this->_telegram == telegram)
        return;

    this->_telegram = telegram;
    this->_notifications->setTelegram(telegram);
    emit telegramChanged();
}

void Core::setKeepRunning(bool keep)
{
    if(keep == this->keepRunning())
        return;

    qApp->setQuitOnLastWindowClosed(!keep);
    emit keepRunningChanged();
}

void Core::beep() const
{
    Notification notification;
    notification.setCategory("x-nemo.messaging.im");
    notification.setAppName(APP_PRETTY_NAME);
    notification.setTimestamp(QDateTime::currentDateTime());
    notification.publish();
}

void Core::notify(const NotificationObject *notificationobj)
{
    if(notificationobj->isCurrentDialog() && (qApp->applicationState() == Qt::ApplicationActive))
    {
        this->beep();
        return;
    }

    Notification* notification = NULL;

    if(!this->_notificationsmap.contains(notificationobj->dialogId()))
    {
        notification = new Notification(this);

        QVariantMap remoteaction;
        remoteaction["name"] = "default";
        remoteaction["service"] = DBUS_INTERFACE;
        remoteaction["path"] = "/";
        remoteaction["iface"] = DBUS_INTERFACE;
        remoteaction["method"] = "openDialog";
        remoteaction["arguments"] = (QVariantList() << notificationobj->dialogId());
        remoteaction["icon"] = "icon-m-notifications";

        notification->setRemoteAction(remoteaction);
        this->_notificationsmap[notificationobj->dialogId()] = notification;

        connect(notification, &Notification::closed, this, &Core::onNotificationClosed);
    }
    else
        notification = this->_notificationsmap[notificationobj->dialogId()];

    notification->setCategory("x-nemo.messaging.im");
    notification->setAppName(APP_PRETTY_NAME);
    notification->setTimestamp(QDateTime::currentDateTime());

    notification->setPreviewSummary(notificationobj->title());
    notification->setSummary(notificationobj->title());

    notification->setPreviewBody(notificationobj->message());
    notification->setBody(notificationobj->message());

    notification->publish();
}

void Core::closeNotification(Dialog *dialog)
{
    TLInt dialogid = TelegramHelper::identifier(dialog);

    if(!this->_notificationsmap.contains(dialogid))
        return;

    Notification* notification = this->_notificationsmap.take(dialogid);
    notification->close();
    notification->deleteLater();
}

void Core::onNotificationClosed(uint)
{
    Notification* notification = qobject_cast<Notification*>(this->sender());
    TLInt dialogid = notification->remoteActions().first().toMap()["arguments"].toList().first().toInt();

    this->_notificationsmap.remove(dialogid);
    notification->deleteLater();
}

void Core::onWakeUpRequested()
{
    emit wakeUpRequested();
}
