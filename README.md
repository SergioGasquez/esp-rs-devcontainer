# esp-rs-devcontainer
This repository uses a container to offer the environment needed to develop applications for [ESP
boards using Rust](https://github.com/esp-rs), it also provides integration with Visual Studio Code using [remote containers](https://code.visualstudio.com/docs/remote/containers).

## Table of Contents

- [Quick Start](#quick-start)
  - [Requirements](#requirements)
  - [Setup](#setup)
    - [[Optional] Podman](#optional-podman)
    - [General](#general)
  - [Running the container](#running-the-container)
  - [Build](#build)
  - [Flash](#flash)
    - [Cargo espflash](#cargo-espflash)
    - [Adafruit ESPTool](#adafruit-esptool)
  - [Monitor](#monitor)
    - [ESPMonitor](#espmonitor)
    - [Online Serial Monitor](#online-serial-monitor)

# Setup

## Requirements
- [Visual Studio Code](https://code.visualstudio.com/download)
  - [Remote - Container Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Docker](https://docs.docker.com/get-docker/)
> ### Using Podman instead of Docker
> Using Podman as conatiner tool is possible when using a Linux host machine.
> When using Podman, flashing devices from the container is possible.
> 
> > There has been some testing using Lima and Podman in others platforms but with
> > no sucess so far. Feel free to test with them and report any feeback.
> #### Requirements
>   - [Install Podman](https://podman.io/getting-started/installation)
>   -  Uncomment the `runArgs` line from `devcontianer.json`:
>   
>       ```
>       "runArgs": ["--userns=keep-id", "--device", "/dev/ttyUSB0", "--security-opt", "label=disable", "--annotation", "run.oci.keep_original_groups=1"],
>       ```
>      - Edit the device argument to match the serial port of your board.
>   - Edit Visual Code Settings:
>     -  Via UI: In _Extension>Remote-Containers_ set `Remote›Containers:Docker Path`
>   to `podman`
>     -  Via JSON: Add the following line:
>         ```
>         "remote.containers.dockerPath": "podman",
>         ```

### General
Select the tag of the [sergiogasquez/esp-rs-env](https://hub.docker.com/repository/docker/sergiogasquez/esp-rs-env)
image you would like to use by modifying the `image` property in
`devcontainer.json`.
For more information regarding the image tags, refer to [esp-rs-container](https://github.com/SergioGasquez/esp-rs-container).


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
    > There is also a `no_std` template project: https://github.com/esp-rs/esp-template

    > Be sure to match the enviroment in the selected image tag (espidf version and board)

## Build
Using [cargo-espflash](https://github.com/esp-rs/espflash) tool is recommended
since it allows to save the generated image in the disk or flash the resulting binary
to the board.

`cargo build` is also available and it generates the resulting application under
target folder

## Flash
Any method of flashing ESP boards from your host device should also work.

### Cargo espflash

> As mentioned before, if using Podman, [cargo espflash](https://github.com/esp-rs/espflash/tree/master/cargo-espflash) can be used to flash the ESP board from the container.
### [Adafruit ESPTool](https://adafruit.github.io/Adafruit_WebSerial_ESPTool/)
WebSerial ESPTool is designed to be a web-capable option for programming ESP boards.

Since the local repository folder is synchronized with the container `~/workspace` folder, we recommend using `cargo espflash save-image --merge <appName>.bin ` to generate a binary.

In orfer to flash it:
1. Open the [Adafruit ESPTool](https://adafruit.github.io/Adafruit_WebSerial_ESPTool/) flashing tool.
2. Choose the desired baudrate.
3. Connect to the serial port of the ESP board.
4. Upload the generated binary.

## Monitor
Any serial monitor used from your host device works, like [espmonitor](https://github.com/esp-rs/espmonitor).

> Using Podman also allows using the argument `--monitor` of cargo-espflash.

### Online Serial Monitor
Using an online serial monitor is also an option [Serial Terminal](https://serial.huhn.me/) working fine in [some browsers](https://developer.mozilla.org/en-US/docs/Web/API/Serial#browser_compatibility).