# esp-rs-devcontainer
This repository uses Docker to offer the enviroment needed to develop applications for [ESP 
boards using Rust](https://github.com/esp-rs), it also offers integration with Visual Studio Code using [remote containers](https://code.visualstudio.com/docs/remote/containers).

## Table of Contents

- [Quick Start](#quick-start)
  - [Requirements](#requirements)
  - [Build](#build)
  - [Flash](#flash)
    - [Adafruit ESPTool](#adafruit-esptool)
  - [Monitor](#monitor)
- [Known Issues](#known-issues)

# Quick Start
This repository is intended to be used with Visual Studio Code, using the
`Remote - Container` extension.
## Requirements
- [Visual Studio Code](https://code.visualstudio.com/download)
  - [Remote - Container Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker](https://docs.docker.com/get-docker/)

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
`cargo +esp espflash save-image --release <imageName>`


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

# Known Issues 
## LIBCLAN_PATH is not properly setted
This error ocurred when using the enviroment in Apple Sillicon
### Error
```
  thread 'main' panicked at 'Unable to find libclang: "couldn't find any valid shared libraries matching: ['libclang.so', 'libclang-*.so', 'libclang.so.*', 'libclang-*.so.*'], set the `LIBCLANG_PATH` environment variable to a path where one of these files can be found (invalid: [])"', /home/vscode/.cargo/registry/src/github.com-1ecc6299db9ec823/bindgen-0.59.2/src/lib.rs:2144:31
  note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
```
### Fix
`export LIBCLANG_PATH=/home/vscode/.espressif/tools/xtensa-esp32-elf-clang/esp-13.0.0-20211203-aarch64-unknown-linux-gnu/xtensa-esp32-elf-clang/lib/`

