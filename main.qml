import QtQuick 2.11
import QtQuick.Window 2.11
import QtWebEngine 1.7

Window {
    visible: true
    width: DeviceInfoProvider.screenWidth
    height: DeviceInfoProvider.screenHeight - DeviceInfoProvider.panelHeight

    WebEngineProfile {
        id: web_engine_profile
        httpUserAgent: "Mozilla/5.0 (Linux; U; Android 9.0; PocketBook 626 Build/5.20.1000; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/65.0.3239.111 Mobile Safari/537.36"
    }

    WebEngineView {
        id: web_engine_view
        anchors.fill: parent
        profile: web_engine_profile
        zoomFactor: DeviceInfoProvider.getDpi() * DeviceInfoProvider.getScaleFactor() / 160

        onLoadProgressChanged: {
            loading_progress.width = loadProgress * (web_engine_view.width / 100)
        }
    }

    Connections {
        target: BrowserData
        onUrlChanged: {
            web_engine_view.url = url
        }
    }

    Rectangle {
        id: loading_progress
        anchors.top: parent.top
        anchors.left: parent.left
        height: 100
        color: "black"
        visible: web_engine_view.loading
    }

    Component.onCompleted: {
        web_engine_view.url = BrowserData.url
    }
}
