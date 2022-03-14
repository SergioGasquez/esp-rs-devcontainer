# esp-rs-devcontainer
This repository uses Docker to offer the enviroment needed to develop applications for [ESP 
boards using Rust](https://github.com/esp-rs), it also offers integration with VsCode using [Remote - Containers](https://code.visualstudio.com/docs/remote/containers)

## Table of Contents

- [Quick Start](#quick-start)
  - [Create a project](#create-a-project)
  - [Build](#build)
  - [Flash](#flash)
    - [Adafruit ESPTool](#adafruit-esptool)

# Quick Start
This repository is intended to be used with Visual Studio Code, using the
`Remote - Container` extension.

After opening the repository folder with Visual Studio Code, a popup will come
up asking to open reopen the folder in a Container. Click `Yes` and after the
container has finished building, you will be asked for the dessired configuration
to generate an application using the [esp-idf-template](https://github.com/esp-rs/esp-idf-template)!

You can skip this for now, using `Ctrl+C`, if you dont want to start from a template,
you can generate a project from a template at any time using:

`cargo generate --git https://github.com/esp-rs/esp-idf-template cargo`

## Build
In order to build the generated application we use [cargo-espflash](https://github.com/esp-rs/espflash) tool which allows us to save the generated image:

`cargo espflash save-image --release <imageName>`

## Flash
Since the repository folder is syncronized with the Docker /home/vscode/esp-rs folder,
you can accress the generated image of your application from the local repository folder.
That being said, there are several ways to flash it.
### [Adafruit ESPTool](https://adafruit.github.io/Adafruit_WebSerial_ESPTool/)
WebSerial ESPTool designed to be a web-capable option for programming ESP boards.

1. Choose the dessired baudrate.
1. Connect to the serial port of the ESP board.
1. Upload the bootloader file, the partition table and the generated 
application image for you board and select the proper offset.
> Default bootloader files and partition tables can be found under the `config-files` folder.

Default Offsets:
|             | **Bootloader** | **Partition Table** | **Application Image** |
|:-----------:|:--------------:|:-------------------:|:---------------------:|
|  **esp32**  |       0x0      |        0x8000       |        0x10000        |
| **esp32s2** |       0x0      |        0x8000       |        0x10000        |
| **esp32s3** |       0x0      |        0x8000       |        0x10000        |
| **esp32c3** |       0x0      |        0x8000       |        0x10000        |

## Monitor
You can use [espmonitor](https://github.com/esp-rs/espmonitor) from your local enviroment to monitor
the output of your ESP board:

`espmonitor /dev/<serialPort>`
