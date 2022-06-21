import QtQuick 2.11
import QtQuick.Window 2.11
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

Window {
    property string primaryColor: "#45B549"
    property string activeColor: "#188b1c"

    id: window
    width: 800
    height: 480
    visible: true
    property alias rectangle1Color: navBar.color
    title: qsTr("DeviceID")


    Rectangle {
        id: statusBar
        height: 45
        color: primaryColor
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0

        RowLayout {
            id: rowLayout
            anchors.fill: parent
            anchors.rightMargin: 5
            anchors.leftMargin: 5




            Text {
                id: text1
                width: 266
                color: "#ffffff"
                text: qsTr("ScaleShoot")
                font.pixelSize: 16
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                Layout.preferredHeight: 100
                Layout.preferredWidth: 200
                Layout.fillWidth: false
                Layout.fillHeight: true
                font.weight: Font.Bold
            }

            ColumnLayout {
                id: columnLayout2
                width: 266
                height: 100
                Layout.preferredHeight: -1
                Layout.preferredWidth: 200
                spacing: 1
                Layout.fillHeight: true
                Layout.fillWidth: false

                Text {
                    id: text2
                    color: "#ffffff"
                    text: qsTr("TIME")
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                    font.weight: Font.Bold
                }

                Text {
                    id: text3
                    color: "#ffffff"
                    text: qsTr("02/06/2022 21:00")
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                }
            }

            ColumnLayout {
                id: columnLayout1
                width: 266
                height: 100
                spacing: 1
                Layout.preferredHeight: -1
                Layout.preferredWidth: 200
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: false

                Text {
                    id: text4
                    color: "#ffffff"
                    text: qsTr("STATUS")
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignRight
                    font.weight: Font.Bold
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                }

                Text {
                    id: text5
                    color: "#ffffff"
                    text: qsTr("Standby")
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignRight
                    Layout.fillHeight: false
                    Layout.fillWidth: true
                }
            }
        }
    }

    Rectangle {
        id: navBar
        y: 402
        height: 78
        color: primaryColor
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0

        Button {
            id: btnManual
            x: 693
            width: 110
            text: qsTr("MANUAL")
            palette.button: primaryColor
            icon.source: "qrc:/icons/manual.svg"
            palette.buttonText: "#ffffff"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            onClicked: {
                palette.button = activeColor
                btnAuto.palette.button = primaryColor
                frameManual.visible = true
            }
        }

        Button {
            id: btnAuto
            width: 110
            text: qsTr("AUTO")
            icon.source: "qrc:/icons/auto.svg"
            palette.button: activeColor
            palette.buttonText: "#fff"
            anchors.right: btnManual.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            onClicked: {
                palette.button = activeColor
                btnManual.palette.button = primaryColor
                frameManual.visible = false
                con.publish("AUTU")
            }
        }

        Button {
            id: btnInGateA
            width: 110
            text: qsTr("GATE A")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            palette.button: activeColor
            icon.source: "qrc:/icons/door.svg"
            palette.buttonText: "#ffffff"
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            onClicked: {
                palette.button = activeColor
                btnInGateB.palette.button = primaryColor
                icon.source = "qrc:/icons/door.svg"
                btnInGateB.icon.source = "qrc:/icons/door_lock.svg"
            }
        }

        Button {
            id: btnInGateB
            width: 110
            text: qsTr("GATE B")
            anchors.left: btnInGateA.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            palette.button: primaryColor
            palette.buttonText: "#ffffff"
            icon.source: "qrc:/icons/door_lock.svg"
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            onClicked: {
                palette.button = activeColor
                btnInGateA.palette.button = primaryColor
                icon.source = "qrc:/icons/door.svg"
                btnInGateA.icon.source = "qrc:/icons/door_lock.svg"
            }
        }
    }

    Rectangle {
        id: frame1
        width: 278
        color: "#ffffff"
        radius: 5
        border.color: primaryColor
        border.width: 2
        anchors.left: parent.left
        anchors.top: statusBar.bottom
        anchors.bottom: navBar.top
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        anchors.leftMargin: 141

        Rectangle {
            id: childFrame1
            height: 70
            color: primaryColor
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0

            Text {
                id: txtWeight
                color: "#ffffff"
                text: qsTr("34 Kg")
                anchors.fill: parent
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Bold
            }
        }

        Image {
            id: imgTarget
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: childFrame1.top
            source: "qrc:/icons/goat.png"
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: frame2
        width: 200
        height: 238
        color: "#ffffff"
        radius: 5
        border.color: "#ffffff"
        border.width: 2
        anchors.left: frame1.right
        anchors.top: statusBar.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 20

        Rectangle {
            id: childFrame2
            height: 39
            color: primaryColor
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0

            Text {
                id: text6
                color: "#ffffff"
                text: qsTr("DATA TARGET")
                anchors.fill: parent
                font.pixelSize: 14
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 5
                Layout.preferredHeight: 100
                Layout.preferredWidth: 200
                Layout.fillHeight: true
                font.weight: Font.Bold
                Layout.fillWidth: false
            }
        }

        ColumnLayout {
            id: columnLayout
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: childFrame2.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: -7
            spacing: 0
            anchors.topMargin: 0

            Rectangle {
                id: rectangle
                width: 200
                height: 200
                color: "#00ffffff"
                border.color: primaryColor
                border.width: 1
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 50

                ColumnLayout {
                    id: columnLayout3
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    spacing: 0

                    Text {
                        id: text7
                        text: qsTr("RFID")
                        font.pixelSize: 12
                        font.weight: Font.Bold
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                        Layout.rowSpan: 0
                        Layout.fillHeight: false
                        Layout.preferredHeight: -1
                    }

                    Text {
                        id: text8
                        text: qsTr("119922812")
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rowSpan: 0
                        Layout.fillHeight: false
                        Layout.preferredHeight: -1
                    }
                }
            }

            Rectangle {
                id: rectangle1
                width: 200
                height: 200
                color: "#00ffffff"
                border.color: primaryColor
                border.width: 1
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 50
                ColumnLayout {
                    id: columnLayout4
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    spacing: 0
                    Text {
                        id: text9
                        text: qsTr("BERAT")
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                        Layout.preferredHeight: -1
                        Layout.rowSpan: 0
                        Layout.fillHeight: false
                        font.weight: Font.Bold
                    }

                    Text {
                        id: text10
                        text: qsTr("30 Kg")
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.preferredHeight: -1
                        Layout.rowSpan: 0
                        Layout.fillHeight: false
                    }
                }
            }

            Rectangle {
                id: rectangle2
                width: 200
                height: 200
                color: "#00ffffff"
                border.color: primaryColor
                border.width: 1
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 50
                ColumnLayout {
                    id: columnLayout5
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    spacing: 0
                    Text {
                        id: text11
                        text: qsTr("TANGGAL TIMBANG")
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                        Layout.rowSpan: 0
                        Layout.preferredHeight: -1
                        Layout.fillHeight: false
                        font.weight: Font.Bold
                    }

                    Text {
                        id: text12
                        text: qsTr("20/06/2022")
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.rowSpan: 0
                        Layout.preferredHeight: -1
                        Layout.fillHeight: false
                    }
                }
            }

            Rectangle {
                id: rectangle3
                width: 200
                height: 200
                color: "#00ffffff"
                border.color: primaryColor
                border.width: 1
                Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                Layout.preferredHeight: 50
                ColumnLayout {
                    id: columnLayout6
                    anchors.fill: parent
                    anchors.leftMargin: 5
                    spacing: 0
                    Text {
                        id: text13
                        text: qsTr("TANGGAL TIMBANG")
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                        Layout.preferredHeight: -1
                        Layout.rowSpan: 0
                        Layout.fillHeight: false
                        font.weight: Font.Bold
                    }

                    Text {
                        id: text14
                        text: qsTr("21:00")
                        font.pixelSize: 12
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.preferredHeight: -1
                        Layout.rowSpan: 0
                        Layout.fillHeight: false
                    }
                }
            }
        }
    }

    Rectangle {
        id: frameManual
        x: 693
        y: 202
        width: 110
        height: 200
        visible: false
        color: "#ffffff"
        border.color: primaryColor
        border.width: 1
        anchors.right: parent.right
        anchors.bottom: navBar.top
        anchors.bottomMargin: 0
        anchors.rightMargin: 0

        Rectangle {
            id: rectangle4
            height: 30
            color: primaryColor
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top

            Text {
                id: text15
                color: "#ffffff"
                text: qsTr("MANUAL")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                rotation: 0
            }
        }

        Button {
            id: btnGateA
            text: qsTr("GATE A")
            icon.source: "qrc:/icons/unlock.svg"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: rectangle4.bottom
            anchors.rightMargin: 2
            anchors.leftMargin: 2
            anchors.topMargin: 2
        }

        Button {
            id: btnGateB
            text: qsTr("GATE B")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: btnGateA.bottom
            anchors.leftMargin: 2
            icon.source: "qrc:/icons/unlock.svg"
            anchors.rightMargin: 2
            anchors.topMargin: 2
        }

        Button {
            id: btnGateA2
            text: qsTr("CAPTURE")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 2
            anchors.leftMargin: 2
            anchors.rightMargin: 2
        }
    }

}
