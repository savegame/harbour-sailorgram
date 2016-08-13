// This file generated by libqtelegram-code-generator.
// You can download it from: https://github.com/Aseman-Land/libqtelegram-code-generator
// DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN

#ifndef TELEGRAMAPI_H
#define TELEGRAMAPI_H

#include "core/abstractapi.h"
#include "core/session.h"
#include "telegram/types/types.h"
#include "secret/secretchat.h"
#include "libqtelegram_global.h"

class LIBQTELEGRAMSHARED_EXPORT TelegramApi : public AbstractApi
{
    Q_OBJECT
    friend class FileHandler;

public:
    explicit TelegramApi(Session *session, Settings *settings, CryptoUtils *crypto, QObject *parent = 0);
    virtual ~TelegramApi();

/*! === methods === !*/
Q_SIGNALS:
/*! === signals === !*/
    void error(qint64 msgId, qint32 errorCode, const QString &errorText, const QString &functionName, const QVariant &attachedData, bool &accepted);

private:
    Settings *mSettings;
    CryptoUtils *mCrypto;

/*! === privates === !*/
    void onError(Query *q, qint32 errorCode, const QString &errorText, const QVariant &attachedData, bool &accepted);
};

#endif // TELEGRAMAPI_H