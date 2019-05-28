#include "device_info_provider.h"
#include <inkview.h>
#include <inkinternal.h>
#include <inkplatform.h>

using namespace pocketbook::utils;

DeviceInfoProvider &DeviceInfoProvider::Instance()
{
    static DeviceInfoProvider *this_ = nullptr;
    if (!this_)
    {
        this_ = new DeviceInfoProvider();
    }
    return *this_;
}

DeviceInfoProvider::DeviceInfoProvider()
{
}

DeviceInfoProvider::~DeviceInfoProvider()
{
}

int DeviceInfoProvider::screenWidth() const
{
    return ::ScreenWidth();
}

int DeviceInfoProvider::screenHeight() const
{
    return ::ScreenHeight();
}

int DeviceInfoProvider::panelHeight() const
{
    return ::PanelHeight();
}

int DeviceInfoProvider::getDpi()
{
    if (dpi_ == -1)
    {
        dpi_ = get_screen_dpi();
    }
    return dpi_;
}

double DeviceInfoProvider::getScaleFactor()
{
    if (-1 == scale_factor_) {
        scale_factor_ = get_screen_scale_factor();
    }
    return scale_factor_;
}

int DeviceInfoProvider::getScreenWidth()
{
    return ::ScreenWidth();
}

int DeviceInfoProvider::getScreenHeight()
{
    return ::ScreenHeight();
}

int DeviceInfoProvider::getPanelHeight() {
    return ::PanelHeight();
}

