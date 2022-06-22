# This Python file uses the following encoding: utf-8
import rc_icon
import os
from pathlib import Path
import sys
import configparser

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2 import QtCore


class Console(QtCore.QObject):
    def __init__(self):
        super().__init__()
        self.config = configparser.ConfigParser()
        self.config.read("config.ini")

    @QtCore.Slot(str, result=str)
    def getConfig(self, key):
        return self.config.get("main", key)

    @QtCore.Slot(str)
    def publish(self, s):
        print(s)

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    context = engine.rootContext()
    console = Console()
    config = configparser.ConfigParser()
    config.read("config.ini")

    context.setContextProperty("con", console)
    engine.load(os.fspath(Path(__file__).resolve().parent / "main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
