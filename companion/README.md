# Companion computer

Raspberry Pi connected to Pixhawk **TELEM2** over UART (MAVLink 2, 921600 baud).

## Wiring
| Pi | Pixhawk TELEM2 |
|---|---|
| GPIO14 (TX) | RX |
| GPIO15 (RX) | TX |
| GND | GND |

Power the Pi from a separate 5 V / 3 A BEC, **not** from the TELEM port.

## ArduPilot settings
```
SERIAL2_PROTOCOL = 2      # MAVLink2
SERIAL2_BAUD     = 921    # 921600
```

## Planned contents
- `heartbeat.py`: connect and print attitude, GPS and battery (first test)
- `guided_square.py`: take off, fly a square, land (SITL first!)
- `video/`: camera stream to the GCS
