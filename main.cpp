#include <QDebug>
#include <QGuiApplication>
#include <QLocale>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTextCodec>
#include <QtWebEngine>

#include <fstream>
#include <sstream>
#include <string>

#include <inklog.h>
#include <inkview.h>

#include <common_utilities/cfg_wrapper.h>

#include "device_info_provider.h"
#include "pbtranslator.h"
#include "resource_image_provider.h"
#include "browserdata.h"

using namespace pocketbook::utilities;

int main(int argc, char *argv[])
{
    setenv("QT_QPA_PLATFORM", "pocketbook2", 1);

#ifndef EMULATOR
    std::string language = readFromConfig<std::string>(GLOBALCONFIGFILE, "language", "en");
    std::string locale = "en_US.UTF-8";
    std::ifstream f("/ebrmain/share/locale/locale.alias");
    std::string s;
    while (getline(f, s).good()) {
        std::istringstream iss(s);
        std::string str_lang, str_locale;
        iss >> str_lang >> str_locale;
        if(language == str_lang) {
            std::size_t pos = str_locale.find_first_of(".");
            str_locale = str_locale.substr(0, pos);
            str_locale.append(".UTF-8");
            locale = str_locale;
            break;
        }
    }
    f.close();
    setenv("LANG", locale.c_str(), 1);
#endif

    QGuiApplication app(argc, argv);
    QLocale::setDefault(QString(std::getenv("LANG")));

#ifndef EMULATOR
    QTextCodec *utfcodec = QTextCodec::codecForName("UTF-8");
    QTextCodec::setCodecForLocale(utfcodec);
#endif

    app.installTranslator(new pocketbook::utils::PBTranslator());

    QFont default_font(QString::fromUtf8(iv_get_default_font(FONT_FAMILY)));

    app.setFont(default_font);

    QtWebEngine::initialize();

    QQmlApplicationEngine engine;

    BrowserData browserData;

    browserData.setUrl("https://google.com");

    if(app.arguments().size() >= 2) {
        browserData.setUrl(app.arguments().back());
    }

    engine.rootContext()->setContextProperty("DeviceInfoProvider", &pocketbook::utils::DeviceInfoProvider::Instance());
    engine.rootContext()->setContextProperty("BrowserData", &browserData);

    const QUrl url(QStringLiteral("qrc:/main.qml"));

    if (!(QueryNetwork() & NET_CONNECTED)) {
        NetConnect2(NULL, 0);
    }

    engine.load(url);

    return app.exec();
}
