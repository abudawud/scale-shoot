# Scale Shoot

## Topic

- Static / harcoded topic
- Single Topic

## Payload

- JSON format
- Code command
- Model based command 

## Subscriber

Monitor healthcheck if needed

## Publisher

- Publish healthcheck periodically
- Publish (PUT) payload when requested (GET)

### Topic Description

- GUI Topic: `scale_shoot_frontend`
- Backend: `scale_shoot_backend`

**NOTE: Topic is harcoded**

### Payload Description

Payload have this JSON structure

```json
{
    "cmd": "x_command",
    "type": "req_type",
    "data": {
        ...
    }
}
```

#### healthcheck

```json
{
    "cmd": "healthcheck",
    "type": "PUT",
    "data": {
        "code": "200",
        "timestamp": "1655541152",
        "message": "ok",
    }
}
```
- type: `PUT` | `GET`

#### capture (GET)

````json
{
    "cmd": "capture",
    "type": "GET",
}
``````
- type: `PUT` | `GET`

#### capture (PUT)

````json
{
    "cmd": "capture",
    "type": "PUT",
    "data": {
      "rfid": "111898123",
      "weight": "35",
      "timestamp": "1655541152"
    }
}
``````
- type: `PUT` | `GET`

#### swap_gate (PUT)

```json
{
    "cmd": "swap_gate",
    "type": "PUT",
    "data" {
        "in": "gate_a",
        "out": "gate_b"
    }
}
```
- type: `PUT` | `GET`
- in / out: Target Gate Id

#### toggle_gate (PUT)

```json
{
    "cmd": "toggle_gate",
    "type": "PUT",
    "data" {
        "target": "gate_a",
        "state": "open"
    }
}
```
- type: `PUT` | `GET`
- state: `open` | `close`
- target: Gate Target id

#### toggle_mode (PUT)

```json
{
    "cmd": "toggle_mode",
    "type": "PUT",
    "data" {
        "mode": "manual",
    }
}
```
- type: `PUT` | `GET`
- mode: `manual` | `auto`
