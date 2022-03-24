# esp-rs-devcontainer
This repository uses a container to offer the environment needed to develop applications for [ESP
boards using Rust](https://github.com/esp-rs), it also provides integration with Visual Studio Code using [remote containers](https://code.visualstudio.com/docs/remote/containers).

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
- [Docker](https://docs.docker.com/get-docker/) or [Podman](https://podman.io/getting-started/installation)

## Setup
There are two ways of using this repository:
- Using Docker: does not allow flashing ESP boards from the container but
has requires fewer configurations.
- Using Podman: allows flashing ESP boards but requires further configurations.

Once the method is chosen, install the selected container tooling application and
in the case of using Podman proceed with the following:
1. Uncomment the `runArgs` line from `devcontianer.json`:
    ```
    "runArgs": ["--userns=keep-id", "--device", "/dev/ttyUSB0", "--security-opt", "label=disable", "--annotation", "run.oci.keep_original_groups=1"],
    ```
    - Edit the device argument to match the serial port of your target device
2. Edit Visual Code Settings, there are 2 ways of doing this: 
    -  UI: In _Extension>Remote-Containers_ set `Remote›Containers:Docker Path`
  to `podman`
    -  JSON: Add the following line:
        ```
        "remote.containers.dockerPath": "podman",
        ```

Select which tag of the [sergiogasquez/esp-rs-env](https://hub.docker.com/repository/docker/sergiogasquez/esp-rs-env)
image you would like to use by modifying the `image` property in
`devcontainer.json`.
For more information regarding the images tag, refer to [esp-rs-container](https://github.com/SergioGasquez/esp-rs-container)
> Using a tag with a prebuilt esp-idf environment is recommended if the host device
is not `linux/amd64`.

## Running the container
1. Open the folder with Visual Studio Code and open the container, there are
   several ways to open the container:
   1. When opening Visual Studio Code, a popup will come up asking to open reopen the folder in a Container, click `Yes`
   1. Open the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) and select `Remote-Containers: Reopen in Container`
   2. Use the open in a remote window button on the bottom left corner to
   `Reopen in Container`
2. Wait for the container to build and run, once the container is running, you
   should have a working environment to develop ESP boards using Rust
   - If you want to generate an application using the [esp-idf-template](https://github.com/esp-rs/esp-idf-template) use:
     - `cargo generate --git https://github.com/esp-rs/esp-idf-template cargo`
       if using a base tag.
     - `cargo generate --git https://github.com/esp-rs/esp-idf-template cargo
       --define espidfver=$ESP_IDF_VER` if using an espidf version tag.
     - `cargo generate --git https://github.com/esp-rs/esp-idf-template cargo
       --define espidfver=$ESP_IDF_VER --define mcu=$ESP_BOARD` if using a
       board version tag.



## Build
Using [cargo-espflash](https://github.com/esp-rs/espflash) tool is recommended
since it allows to save the generated image in the disk or flash the resulting binary
to the board.
> Note that flashing from the container only available when using Podman


## Flash

### Cargo espflash
If using Podman, [cargo espflash](https://github.com/esp-rs/espflash/tree/master/cargo-espflash) can be used to flash the ESP board as in native environments.
### [Adafruit ESPTool](https://adafruit.github.io/Adafruit_WebSerial_ESPTool/)
WebSerial ESPTool is designed to be a web-capable option for programming ESP boards.

Since the local repository folder is synchronized with the container `/home/vscode/workspace` folder, if `cargo espflash save-image` was used, the generated binary of your application can be accessed from the local repository folder.
1. Open the [Adafruit ESPTool](https://adafruit.github.io/Adafruit_WebSerial_ESPTool/) flashing tool.
1. Choose the desired baudrate.
2. Connect to the serial port of the ESP board.
3. Upload the bootloader file, the partition table and the generated 
application image binary and select the proper offset.
> Default bootloader files and partition tables can be found under the `config-files` folder.

Default Offsets:
|             | **Bootloader** | **Partition Table** | **Application Image** |
|:-----------:|:--------------:|:-------------------:|:---------------------:|
|  **esp32**  |       0x0      |        0x8000       |        0x10000        |
| **esp32s2** |       0x0      |        0x8000       |        0x10000        |
| **esp32s3** |       0x0      |        0x8000       |        0x10000        |
| **esp32c3** |       0x0      |        0x8000       |        0x10000        |

## Monitor
If using Podman, `cargo espflash --monitor` can be used from the container.

You can use [espmonitor](https://github.com/esp-rs/espmonitor) from your local
environment to monitor the output of your ESP board: `espmonitor /dev/<serialPort>`

