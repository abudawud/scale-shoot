# This Python file uses the following encoding: utf-8
from PySide2 import QtCore
import configparser
import paho.mqtt.client as client
import json as json
import os
from pathlib import Path
from datetime import datetime
from time import time, sleep
from threading import Thread
import netifaces


class Console(QtCore.QObject):
    def __init__(self):
        super().__init__()
        self.config = configparser.ConfigParser()
        self.config.read(os.fspath(Path(__file__).resolve().parent / "config.ini"))
        self.mqtt_data = []
        self.mqtt = client.Client()
        self.lastHealthcheck = time()

        # qml property
        self._weight = "0 Kg"
        self._rfid = "-"
        self._timestamp = "-,-"
        self._capturefile = "qrc:/icons/goat.png"
        self._deviceid = "unknown"
        self._status = "Offline"
        self._mqttOk = False

        self.sc_thread = Thread(target=self._self_check)
        self.sc_thread.daemon = True
        self.sc_thread.start()
        self.initMqtt()

    def initMqtt(self):
        try:
            self.mqtt.connect(self.config.get("main", "broker_uri"))
            self.mqtt.on_message = self.on_message
            self.mqtt.subscribe("scale_shoot_backend")
            self.mqtt.loop_start()
            self._mqttOk = True
            self.status = "Offline"
        except:
            self._mqttOk = False
            self.status = "No MQTT"
            print("Err: failed to connect mqtt on ",
                  self.config.get("main", "broker_uri"))

    def _self_check(self):
        while True:
            # check backend timeout
            if (time() - self.lastHealthcheck) > 10:
                self.lastHealthcheck = time()
                if self._mqttOk:
                    self.status = "Offline"
                self.deviceid = "Disconnected"
                print("Device Offline: no healthcheck received within 10s")
            sleep(3)

            if self._mqttOk is False:
                self.initMqtt()

    def on_message(self, client, userdata, message):
        payload = json.loads(message.payload)
        cmd = payload["cmd"]
        type = payload["type"]
        if cmd == "capture" and type == "PUT":
            data = payload["data"]
            self.weight = "{0} Kg".format(data["weight"])
            self.rfid = data["rfid"]
            self.capturefile = "file:///{0}".format(data["capture_file"])
            dt = datetime.fromtimestamp(data["timestamp"])
            self.timestamp = dt.strftime("%d/%m/%Y,%H:%M:%S")
        elif cmd == "healthcheck" and type == "PUT":
            data = payload["data"]
            self.status = data["message"]
            self.deviceid = data["device_id"]
            self.lastHealthcheck = data["timestamp"]

    def publish(self, payload):
        if self._mqttOk:
            self.mqtt.publish("scale_shoot_frontend", json.dumps(payload))

    @QtCore.Slot(str, result=str)
    def getConfig(self, key):
        return self.config.get("main", key)

    @QtCore.Slot(result=str)
    def getIPAddr(self):
        ipAddr = "unknown"
        iface = self.config.get("main", "iface")

        try:
            ipAddr = netifaces.ifaddresses(iface)[2][0]['addr']
        except ValueError:
            ipAddr = "iface " + iface + " not found"
        except KeyError:
            ipAddr = iface + " not connected"
        except:
            ipAddr = "unknown error"

        return ipAddr

    @QtCore.Slot(str, str)
    def setWifi(self, ssid, psk):
        self.config.set("main", "ssid", ssid)
        self.config.set("main", "psk", psk)
        self.publish({
            "cmd": "wifi_config",
            "type": "PUT",
            "data": {
                "ssid": ssid,
                "psk": psk
            }
        })
        with open("config.ini", "w") as configfile:
            self.config.write(configfile)

    @QtCore.Slot(str)
    def evalCMD(self, s):
        if s == "capture":
            self.publish({
                "cmd": "capture",
                "type": "GET",
            })
        elif s == "swap_gate_in_a" or s == "swap_gate_in_b":
            gateIn = "gate_x"
            gateOut = "gate_x"
            if s == "swap_gate_in_a":
                gateIn = "gate_a"
                gateOut = "gate_b"
            else:
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
                target = "gate_a"
            else:
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
                mode = "manual"
            else:
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

    def _get_capturefile(self):
        return self._capturefile

    def _set_capturefile(self, capturefile):
        self._capturefile = capturefile
        self.on_capturefile.emit()

    def _get_status(self):
        return self._status

    def _set_status(self, status):
        self._status = status
        self.on_status.emit()

    def _get_deviceid(self):
        return self._deviceid

    def _set_deviceid(self, deviceid):
        self._deviceid = deviceid
        self.on_deviceid.emit()

    on_weight = QtCore.Signal()
    on_rfid = QtCore.Signal()
    on_timestamp = QtCore.Signal()
    on_capturefile = QtCore.Signal()
    on_deviceid = QtCore.Signal()
    on_status = QtCore.Signal()

    weight = QtCore.Property(str, _get_weight, _set_weight, notify=on_weight)
    rfid = QtCore.Property(str, _get_rfid, _set_rfid, notify=on_rfid)
    timestamp = QtCore.Property(str, _get_timestamp, _set_timestamp,
                                notify=on_timestamp)
    capturefile = QtCore.Property(str, _get_capturefile, _set_capturefile,
                                  notify=on_capturefile)
    status = QtCore.Property(str, _get_status, _set_status, notify=on_status)
    deviceid = QtCore.Property(str, _get_deviceid, _set_deviceid,
                               notify=on_deviceid)
