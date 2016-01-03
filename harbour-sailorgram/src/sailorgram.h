#ifndef SAILORGRAM_H
#define SAILORGRAM_H

#include <QGuiApplication>
#include <QUrl>
#include <QFile>
#include <QStandardPaths>
#include <QImage>
#include <QMimeDatabase>
#include <telegramqml.h>
#include <telegram.h>
#include <objects/types.h>
#include "heartbeat.h"

class SailorGram : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool keepRunning READ keepRunning WRITE setKeepRunning NOTIFY keepRunningChanged)
    Q_PROPERTY(bool connected READ connected NOTIFY connectedChanged)
    Q_PROPERTY(int interval READ interval WRITE setInterval NOTIFY intervalChanged)
    Q_PROPERTY(TelegramQml* telegram READ telegram WRITE setTelegram NOTIFY telegramChanged)
    Q_PROPERTY(QString emojiPath READ emojiPath CONSTANT FINAL)

    public:
        explicit SailorGram(QObject *parent = 0);
        bool keepRunning() const;
        bool connected() const;
        int interval() const;
        void setInterval(int interval);
        QString emojiPath() const;
        TelegramQml* telegram() const;
        void setTelegram(TelegramQml* telegram);
        void setKeepRunning(bool keep);

    public slots:
        bool fileIsPhoto(const QString& filepath);
        bool fileIsVideo(const QString& filepath);
        void moveMediaToDownloads(MessageMediaObject* messagemediaobject);
        void moveMediaToGallery(MessageMediaObject* messagemediaobject);
        QString fileName(const QString& filepath);
        FileLocationObject *mediaLocation(MessageMediaObject* messagemediaobject);

    private:
        void moveMediaTo(FileLocationObject* locationobj, const QString& destination);

    private slots:
        void startHeartBeat();
        void wakeSleep();

    signals:
        void keepRunningChanged();
        void connectedChanged();
        void intervalChanged();
        void telegramChanged();

    private:
        TelegramQml* _telegram;
        HeartBeat* _heartbeat;
        QMimeDatabase _mimedb;

    private:
        static const QString EMOJI_FOLDER;
};

#endif // SAILORGRAM_H
