#include "browserdata.h"

#include <QCoreApplication>

BrowserData::BrowserData(QObject *parent) : QObject(parent)
{

}

QString BrowserData::url() const
{
    return m_url;
}

void BrowserData::setUrl(QString url)
{
    if (m_url == url)
        return;

    m_url = url;
    emit urlChanged(m_url);
}

void BrowserData::close()
{
    qApp->quit();
}
