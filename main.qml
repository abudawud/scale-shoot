import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.0

Window {
    width: 800
    height: 480
    visible: true
    title: qsTr("Hello World")


    Button {
        id: button
        x: 156
        y: 256
        text: qsTr("Button")
    }

    Image {
        id: image
        x: 0
        y: 0
        width: 800
        height: 42
        source: "qrc:/qtquickplugin/images/template_image.png"
        fillMode: Image.PreserveAspectFit
    }
}
