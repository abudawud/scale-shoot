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

### Command List

|Command|Type|Description|
|-------|-----|------|
|[healthcheck](#healthcheck)|PUT|Realtime status node|
|[capture](#capture)|PUT, GET|Send / Request capture|
|[swap_gate](#swap_gate)|GET|Change gate A->B and vice versa|
|[toggle_gate](#toggle_gate)|PUT|Open / Close Gate|
|[toggle_mode](#toggle_mode)|PUT|Change mode manual / automatic|


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

#### capture

*GET*
```json
{
    "cmd": "capture",
    "type": "GET",
}
```

*PUT*
```json
{
    "cmd": "capture",
    "type": "PUT",
    "data": {
      "device_id": "77:98:17:AA",
      "rfid": "111898123",
      "capture_file": "/paht/to/file.jpg",
      "weight": "35",
      "timestamp": "1655541152"
    }
}
```

#### swap_gate

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
- in / out: Target Gate Id

#### toggle_gate

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

#### toggle_mode

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
