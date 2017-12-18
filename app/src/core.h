#ifndef CORE_H
#define CORE_H

#include <QGuiApplication>
#include <objects/notifications/telegramnotifications.h>
#include <objects/notifications/notificationobject.h>
#include "dbus/interface/dbusinterface.h"
#include "dbus/notification/notification.h"
#include "item/translationinfoitem.h"

class Core : public QObject
{
    Q_OBJECT

    Q_PROPERTY(Telegram* telegram READ telegram WRITE setTelegram NOTIFY telegramChanged)
    Q_PROPERTY(QString version READ version CONSTANT FINAL)
    Q_PROPERTY(int apiId READ apiId CONSTANT FINAL)
    Q_PROPERTY(QString apiHash READ apiHash CONSTANT FINAL)
    Q_PROPERTY(QString hostIp READ hostIp CONSTANT FINAL)
    Q_PROPERTY(int hostPort READ hostPort CONSTANT FINAL)
    Q_PROPERTY(int dcId READ dcId CONSTANT FINAL)
    Q_PROPERTY(bool keepRunning READ keepRunning WRITE setKeepRunning NOTIFY keepRunningChanged)
    Q_PROPERTY(QString emojiPath READ emojiPath CONSTANT FINAL)
    Q_PROPERTY(QString publicKey READ publicKey CONSTANT FINAL)
    Q_PROPERTY(QString homeFolder READ homeFolder CONSTANT FINAL)
    Q_PROPERTY(QString sdcardFolder READ sdcardFolder CONSTANT FINAL)
    Q_PROPERTY(QString picturesFolder READ picturesFolder CONSTANT FINAL)
    Q_PROPERTY(QString androidStorage READ androidStorage CONSTANT FINAL)
    Q_PROPERTY(QString voiceRecordPath READ voiceRecordPath CONSTANT FINAL)
    Q_PROPERTY(TelegramNotifications* notifications READ notifications CONSTANT FINAL)
    Q_PROPERTY(QList<QObject *> translations READ translations CONSTANT FINAL)

    public:
        explicit Core(QObject *parent = 0);
        Telegram* telegram() const;
        QString version() const;
        int apiId() const;
        QString apiHash() const;
        QString hostIp() const;
        int hostPort() const;
        int dcId() const;
        bool keepRunning() const;
        QString emojiPath() const;
        QString publicKey() const;
        QString homeFolder() const;
        QString sdcardFolder() const;
        QString picturesFolder() const;
        QString androidStorage() const;
        QString voiceRecordPath() const;
        TelegramNotifications* notifications() const;
        QList<QObject *> translations() const;
        void setTelegram(Telegram* telegram);
        void setKeepRunning(bool keep);

    private:
        void beep() const;

    private slots:
        void notify(const NotificationObject *notificationobj);
        void closeNotification(Dialog* dialog);
        void onNotificationClosed(uint);
        void onWakeUpRequested();

    signals:
        void telegramChanged();
        void keepRunningChanged();
        void wakeUpRequested();
        void openDialogRequested(TLInt dialogid);

    private:
        QHash<TLInt, Notification*> _notificationsmap;
        TelegramNotifications* _notifications;
        DBusInterface* _interface;
        Telegram* _telegram;
};

#endif // CORE_H
