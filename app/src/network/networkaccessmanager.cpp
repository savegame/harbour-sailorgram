#include "networkaccessmanager.h"
#include <QNetworkReply>
#include <QIODevice>

NetworkAccessManager::NetworkAccessManager(QObject *parent /*= 0*/, const QString& userAgent /*= ""*/) :
    QNetworkAccessManager(parent),
    _userAgent(userAgent)
{
}

QNetworkReply *NetworkAccessManager::createRequest(Operation op, const QNetworkRequest& req, QIODevice *outgoingData /*= 0*/)
{
    QNetworkRequest newReq(req);
    newReq.setRawHeader("User-Agent", _userAgent.toLatin1());

    QNetworkReply *reply = QNetworkAccessManager::createRequest(op, newReq, outgoingData);
    return reply;
}
