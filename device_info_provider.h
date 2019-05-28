#ifndef DEVICEINFOPROVIDER_H
#define DEVICEINFOPROVIDER_H

#include <QObject>

namespace pocketbook { namespace utils {

class DeviceInfoProvider : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int screenWidth READ screenWidth NOTIFY screenWidthChanged)
    Q_PROPERTY(int screenHeight READ screenHeight NOTIFY screenHeightChanged)
    Q_PROPERTY(int panelHeight READ panelHeight NOTIFY panelHeightChanged)

public:
    static DeviceInfoProvider &Instance();
    ~DeviceInfoProvider();

    int screenWidth() const;
    int screenHeight() const;
    int panelHeight() const;

signals:
    void screenWidthChanged();
    void screenHeightChanged();
    void panelHeightChanged();

public slots:
    int getDpi();
    double getScaleFactor();
    int getScreenWidth();
    int getScreenHeight();
    int getPanelHeight();

private:
    DeviceInfoProvider();

    int dpi_ = -1;
    double scale_factor_ = -1;

    int state_ = 1;
};

}} // namespace

#endif // DEVICEINFOPROVIDER_H
