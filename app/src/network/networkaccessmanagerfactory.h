#ifndef NETWORKACCESSMANAGERFACTORY_H
#define NETWORKACCESSMANAGERFACTORY_H

#include <QQmlNetworkAccessManagerFactory>
#include <QString>

class NetworkAccessManagerFactory : public QQmlNetworkAccessManagerFactory
{
public:
    NetworkAccessManagerFactory(const QString& userAgent = "");

    virtual QNetworkAccessManager *create(QObject *parent);
    void setUserAgent(const QString& userAgent);

private:
    QString _userAgent;
};

#endif // NETWORKACCESSMANAGERFACTORY_H
