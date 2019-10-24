import QtQuick 2.11
import QtQuick.Window 2.11
import QtWebEngine 1.7

Window {
    visible: true
    width: DeviceInfoProvider.screenWidth
    height: DeviceInfoProvider.screenHeight - DeviceInfoProvider.panelHeight

    WebEngineProfile {
        id: web_engine_profile
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
