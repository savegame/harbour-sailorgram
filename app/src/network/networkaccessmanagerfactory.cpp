#include "networkaccessmanagerfactory.h"
#include "networkaccessmanager.h"
#include <QNetworkAccessManager>

NetworkAccessManagerFactory::NetworkAccessManagerFactory(const QString &userAgent /*= "" */) :
    QQmlNetworkAccessManagerFactory(),
    _userAgent(userAgent)
{
}

QNetworkAccessManager *NetworkAccessManagerFactory::create(QObject *parent)
{
    QNetworkAccessManager *manager = new NetworkAccessManager(parent, _userAgent);
    return manager;
}

void NetworkAccessManagerFactory::setUserAgent(const QString &userAgent)
{
    if (userAgent != _userAgent)
        _userAgent = userAgent;
}
