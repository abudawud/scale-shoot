# This Python file uses the following encoding: utf-8
from PySide2 import QtCore
import configparser
import paho.mqtt.client as client
import json as json


class Console(QtCore.QObject):
    def __init__(self):
        super().__init__()
        self.config = configparser.ConfigParser()
        self.config.read("config.ini")
        self.mqtt = client.Client()
        self.mqtt_data = []
        self.mqtt.on_message = self.on_message
        self.mqtt.connect(self.config.get("main", "broker_uri"))
        self.mqtt.loop_start()

    def on_message(self, client, userdata, message):
        self.mqtt_data = message.payload

    @QtCore.Slot(str, result=str)
    def getConfig(self, key):
        return self.config.get("main", key)

    @QtCore.Slot(str)
    def publish(self, s):
        print(s)
