#ifndef NETWORKACCESSMANAGER_H
#define NETWORKACCESSMANAGER_H

#include <qnetworkaccessmanager.h>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QString>

class QNetworkReply;
class QIODevice;

class NetworkAccessManager : public QNetworkAccessManager
{
public:
    explicit NetworkAccessManager(QObject *parent = 0, const QString& userAgent = "");

protected:
    QNetworkReply *createRequest(Operation op, const QNetworkRequest& req, QIODevice *outgoingData = 0);

private:
    QString _userAgent;
};

#endif // NETWORKACCESSMANAGER_H
