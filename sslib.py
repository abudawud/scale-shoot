# This Python file uses the following encoding: utf-8
from PySide2 import QtCore
import configparser
import paho.mqtt.client as client
import json as json
from datetime import datetime


class Console(QtCore.QObject):
    def __init__(self):
        super().__init__()
        self.config = configparser.ConfigParser()
        self.config.read("config.ini")
        self.mqtt = client.Client()
        self.mqtt_data = []
        self.mqtt.on_message = self.on_message
        self.mqtt.connect(self.config.get("main", "broker_uri"))
        self.mqtt.subscribe("scale_shoot_backend")
        self.mqtt.loop_start()

        # qml property
        self._weight = "0 Kg"
        self._rfid = "-"
        self._timestamp = "-,-"
        self._capturefile = ""

    def on_message(self, client, userdata, message):
        payload = json.loads(message.payload)
        cmd = payload["cmd"]
        type = payload["type"]
        if cmd == "capture" and type == "PUT":
            data = payload["data"]
            self.weight = data["weight"]
            self.rfid = data["rfid"]
            dt = datetime.fromtimestamp(data["timestamp"])
            self.timestamp = dt.strftime("%d/%m/%Y,%H:%M:%S")

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

    def _get_weight(self):
        return self._weight

    def _set_weight(self, weight):
        self._weight = weight
        self.on_weight.emit()

    def _get_rfid(self):
        return self._rfid

    def _set_rfid(self, rfid):
        self._rfid = rfid
        self.on_rfid.emit()

    def _get_timestamp(self):
        return self._timestamp

    def _set_timestamp(self, timestamp):
        self._timestamp = timestamp
        self.on_timestamp.emit()

    on_weight = QtCore.Signal()
    on_rfid = QtCore.Signal()
    on_timestamp = QtCore.Signal()
    on_capturefile = QtCore.Signal()

    weight = QtCore.Property(str, _get_weight, _set_weight, notify=on_weight)
    rfid = QtCore.Property(str, _get_rfid, _set_rfid, notify=on_rfid)
    timestamp = QtCore.Property(str, _get_timestamp, _set_timestamp,
                                notify=on_timestamp)
