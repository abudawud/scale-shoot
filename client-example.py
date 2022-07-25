from time import sleep
import paho.mqtt.client as client
import json as json
import random
from pathlib import Path
import os
import time

mqtt = client.Client()

def publish(data):
    mqtt.publish("scale_shoot_backend", json.dumps(data))

def on_message(client, userdata, msg):
    payload = json.loads(msg.payload)
    cmd = payload["cmd"]
    if cmd == "capture":
        print("capture requested, i will send the response A.S.A.P")
        pwd = os.fspath(Path(__file__).resolve().parent)
        publish({
            "cmd": "capture",
            "type": "PUT",
            "data": {
                "rfid": str(random.random()).split(".")[1],
                "weight": random.randint(20, 100),
                "timestamp": time.time(),
                "capture_file": "{0}/captures/target-{1}.png".format(pwd, random.randint(1,5))
            }
        })
    elif cmd == "open_gate":
        print("i will open gate: ", payload["data"]["target"])
    elif cmd == "toggle_mode":
        print("switching mode to: ", payload["data"]["mode"])
    elif cmd == "swap_gate":
        print("Swaping gate, in: ", payload["data"]["in"], " out: ", payload["data"]["out"])

def healthcheck():
    publish({
        "cmd": "healthcheck",
        "type": "PUT",
        "data": {
            "device_id": "0000000014b3e2490",
            "code": "200",
            "timestamp": time.time(),
            "message": "Online",
        }
    })


if __name__ == "__main__":
    mqtt.on_message=on_message
    mqtt.connect("127.0.0.1")
    mqtt.subscribe("scale_shoot_frontend")
    mqtt.loop_start()

    while True:
        healthcheck()
        sleep(3)
