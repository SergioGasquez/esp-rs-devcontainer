# esp-rs-devcontainer
This repository uses a container to offer the enviroment needed to develop applications for [ESP 
boards using Rust](https://github.com/esp-rs), it also offers integration with Visual Studio Code using [remote containers](https://code.visualstudio.com/docs/remote/containers).

## Table of Contents

- [Quick Start](#quick-start)
  - [Requirements](#requirements)
  - [Build](#build)
  - [Flash](#flash)
    - [Adafruit ESPTool](#adafruit-esptool)
  - [Monitor](#monitor)

# Quick Start
This repository is intended to be used with Visual Studio Code, using the
`Remote - Container` extension.
## Requirements
- [Visual Studio Code](https://code.visualstudio.com/download)
  - [Remote - Container Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- (Optional)[Docker](https://docs.docker.com/get-docker/)
- (Optional)[Podman](https://podman.io/getting-started/installation)

There are two ways of using this repository:
- Using Docker which does not allow flashing ESP boards from the container but
has requires less configurations.
- Using Podamn which allows flashing ESP boards but requires further configurations.

Once the method is choosed, install the selected continer tooling application and
in case of using Podman proceed with the following:
1. Uncomment the `runArgs` line from `devcontianer.json`:
    ```
    "runArgs": ["--userns=keep-id", "--device", "/dev/ttyUSB0", "--security-opt", "label=disable", "--annotation", "run.oci.keep_original_groups=1"],
    ```
    - Edit the device argument to match the serial port of your target device
2. Edit Visual Code Settings, there are 2 ways of doing this: 
    -  UI: In Extension>Remote-Containers set `Remote›Containers:Docker Path`
  to `podman`
    -  JSON: Add the following line:
        ```
        "remote.containers.dockerPath": "podman",
        ```


After opening the repository folder with Visual Studio Code, a popup will come
up asking to open reopen the folder in a Container. Click `Yes` and after the
container has finished building, you will be asked for the dessired configuration
to generate an application using the [esp-idf-template](https://github.com/esp-rs/esp-idf-template)!

You can skip this for now, using `Ctrl+C`, if you dont want to start from a template,
you can generate a project from a template at any time using:

`cargo generate --git https://github.com/esp-rs/esp-idf-template cargo`

## Build
In order to build the generated application we need to enter the project folder and use the [cargo-espflash](https://github.com/esp-rs/espflash) tool which 
allows us to save the generated image in the disk instead of flashing to device:

`cargo espflash save-image --release <imageName>.bin`

`cargo +esp espflash save-image --release <imageName>.bin`

## Flash
Since the local repository folder is syncronized with the container /home/vscode/dev folder,
you can accress the generated image of your application from the local repository folder.
That being said, there are several ways to flash it.

### Cargo espflash
If using Podman, [cargo espflash](https://github.com/esp-rs/espflash/tree/master/cargo-espflash) can be used to flash the ESP board as in native enviroments.
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