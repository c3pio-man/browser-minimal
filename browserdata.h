#ifndef BROWSERDATA_H
#define BROWSERDATA_H

#include <QObject>

class BrowserData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY urlChanged)

public:
    explicit BrowserData(QObject *parent = nullptr);
    QString url() const;

signals:
    void urlChanged(QString url);

public slots:
    void setUrl(QString url);
    void close();

private:
    QString m_url;
};

#endif // BROWSERDATA_H
