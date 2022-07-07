import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Window {
    id: settingWindow
    width: 400
    height: 250
    title: "Aslis - Setting"
    modality: Qt.ApplicationModal
    visible: true
    color: "#ffffff"

    TextField {
        id: txtSSID
        x: 140
        y: 67
        width: 200
        height: 35
        text: con.getConfig("ssid")
        placeholderText: qsTr("SSID")
    }

    TextField {
        id: txtPass
        x: 140
        y: 108
        width: 200
        height: 35
        text: con.getConfig("psk")
        placeholderText: qsTr("PASSWORD")
    }

    Label {
        id: label
        x: 37
        y: 74
        text: qsTr("SSID")
    }

    Label {
        id: label1
        x: 37
        y: 115
        text: qsTr("PASSWORD")
    }

    Button {
        id: button
        x: 289
        y: 199
        text: qsTr("SIMPAN")
        onClicked: {
            con.setWifi(txtSSID.text, txtPass.text)
            settingWindow.visible = false
        }
    }
}
