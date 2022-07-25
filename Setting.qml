import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Window {
    id: settingWindow
    width: 400
    height: 250
    title: "Aslis - Setting"
    x: 200
    y: 115
    flags: Qt.FramelessWindowHint
    modality: Qt.ApplicationModal
    visible: true
    color: "#ffffff"

    function twoDigit(num) {
        return num < 10 ? "0" + num : num;
    }

    function toDateTime(ts) {
        const date = new Date(ts)
        const day = twoDigit(date.getDate())
        const month = twoDigit(date.getMonth())
        const year = date.getFullYear()
        const hours = twoDigit(date.getHours())
        const minutes = twoDigit(date.getMinutes())
        const second = twoDigit(date.getSeconds())

        return day + '/' + month + '/' + year + ' ' + hours + ':' + minutes + ':' + second
    }

    function getCurrentTime() {
        const date = new Date()
        const day = twoDigit(date.getDate())
        const month = twoDigit(date.getMonth())
        const year = date.getFullYear()
        const hours = twoDigit(date.getHours())
        const minutes = twoDigit(date.getMinutes())
        const second = twoDigit(date.getSeconds())

        return day + '/' + month + '/' + year + ' ' + hours + ':' + minutes + ':' + second
    }

    TabBar {
        id: bar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        TabButton {
            text: qsTr("WiFi")
        }
        TabButton {
            text: qsTr("Calibration")
        }
    }

    SwipeView {
        width: parent.width
        anchors.top: bar.bottom
        anchors.topMargin: -40
        currentIndex: bar.currentIndex
        Item {
            id: homeTab
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
            Label {
                id: label2
                x: 37
                y: 157
                text: qsTr("IP ADDR")
            }

            Label {
                id: lblIpAddr
                x: 140
                y: 157
                text: qsTr("0.0.0.0")
                font.weight: Font.Bold
            }

            Button {
                id: button1
                x: 284
                y: 153
                width: 56
                height: 30
                icon.source: "qrc:/icons/refresh.svg"
                text: qsTr("")
                onClicked: {
                    lblIpAddr.text = con.getIPAddr()
                }
            }
            Rectangle {
                id: rectangle
                x: 0
                y: 199
                width: 400
                height: 51
                color: "#3c3c3c"

                Button {
                    id: button
                    x: 296
                    y: 6
                    text: qsTr("SIMPAN")
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    onClicked: {
                        con.setWifi(txtSSID.text, txtPass.text)
                        settingWindow.visible = false
                   }
                }

                Button {
                    id: button2
                    y: 6
                    palette.button: "red"
                    palette.buttonText: "white"
                    text: qsTr("BATAL")
                    anchors.left: parent.left
                    anchors.leftMargin: 6
                    onClicked: {
                        settingWindow.visible = false
                    }
                }
            }
        }
        Item {
            id: discoverTab
            Label {
                id: label12
                x: 37
                y: 90
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Kalibrasi Terakhir")
            }
            Label {
                id: lblLastCalibrated
                x: 37
                y: 120
                font.bold: true
                font.pixelSize: 20
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                text: toDateTime(parseFloat(con.getConfig("last_calibrated")) * 1000)
            }
            Rectangle {
                id: rectangle2
                x: 0
                y: 199
                width: 400
                height: 51
                color: "#3c3c3c"

                Button {
                    id: button3
                    x: 296
                    y: 6
                    text: qsTr("KALIBRASI")
                    anchors.right: parent.right
                    anchors.rightMargin: 4
                    onClicked: {
                        con.setCalibration()
                        lblLastCalibrated.text = getCurrentTime()
                    }

                }

                Button {
                    id: button4
                    y: 6
                    palette.button: "red"
                    palette.buttonText: "white"
                    text: qsTr("SELESAI")
                    anchors.left: parent.left
                    anchors.leftMargin: 6
                    onClicked: {
                        settingWindow.visible = false
                    }
                }
            }
        }

    }
}
