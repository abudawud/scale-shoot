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

    def publish(self, payload):
        self.mqtt.publish("scale_shoot_frontend", json.dumps(payload))

    @QtCore.Slot(str, result=str)
    def getConfig(self, key):
        return self.config.get("main", key)

    @QtCore.Slot(str)
    def evalCMD(self, s):
        if s == "capture":
            print("capture")
            self.publish({
                "cmd": "capture",
                "type": "GET",
            })
        elif s == "swap_gate_in_a" or s == "swap_gate_in_b":
            gateIn = "gate_x"
            gateOut = "gate_x"
            if s == "swap_gate_in_a":
                print("in a")
                gateIn = "gate_a"
                gateOut = "gate_b"
            else:
                print("in b")
                gateIn = "gate_b"
                gateOut = "gate_a"

            self.publish({
                "cmd": "swap_gate",
                "type": "PUT",
                "data": {
                    "in": gateIn,
                    "out": gateOut
                }
            })
        elif s == "open_gate_a" or s == "open_gate_b":
            target = "gate_x"
            if s == "open_gate_a":
                print("open gate a")
                target = "gate_a"
            else:
                print("open gate b")
                target = "gate_b"

            self.publish({
                "cmd": "open_gate",
                "type": "PUT",
                "data": {
                    "target": target
                 }
            })
        elif s == "toggle_mode_manual" or s == "toggle_mode_auto":
            mode = "x"
            if s == "toggle_mode_manual":
                print("manual")
                mode = "manual"
            else:
                print("auto")
                mode = "auto"
            self.publish({
                "cmd": "toggle_mode",
                "type": "PUT",
                "data": {
                    "mode": mode
                 }
            })
