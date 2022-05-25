# esp-rs-devcontainer

This repository uses a container to offer the environment needed to develop applications for [ESP
boards using Rust](https://github.com/esp-rs), it also provides integration with Visual Studio Code using [remote containers](https://code.visualstudio.com/docs/remote/containers), [GitHub Codespaces](https://docs.github.com/es/codespaces/developing-in-codespaces) and [Gitpod](https://www.gitpod.io/).

For instructions on how to integrate devcontainers to existing repositories, see
[this section](#integrating-devcontainer-in-existing-repositories).

This repository is can be used as template repository.

# Table of Contents

- [Setup](#setup)
- [Build](#build)
- [Flash](#flash)
- [Wokwi Simulation](#wokwi-simulation)
  - [Debuging with Wokwi](#debuging-with-wokwi)
- [Integrating devcontainer in existing repositories](#integrating-devcontainer-in-existing-repositories)

# Setup
The repository supports:
-  [Gitpod](https://gitpod.io/): [![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/github.com/SergioGasquez/esp-rs-devcontainer)
-  [Vs Code Devcontainers](https://code.visualstudio.com/docs/remote/containers#_quick-start-open-an-existing-folder-in-a-container)
-  [GitHub Codespaces](https://docs.github.com/en/codespaces/developing-in-codespaces/creating-a-codespace)
    > **Note**
    > When using GitHub Codespaces, we need to make the ports
    > public, [see instructions](https://docs.github.com/en/codespaces/developing-in-codespaces/forwarding-ports-in-your-codespace#sharing-a-port).

Before opening the devcontainer, edit:
- `.devcontainer/devcontainer.json`: Select the image or configure the args
- `.gitpod.Dockerfile`: Configure the args


Wait for the container to build, once the container is running, you
should have a working environment to develop ESP boards using Rust.


We reccomend using one of our templates with [cargo-generate](https://github.com/cargo-generate/cargo-generate)(already installed by in the images) as starting project:
- [esp-idf-template](https://github.com/esp-rs/esp-idf-template): ESP-IDF Template
  - `cargo generate --vcs none --git https://github.com/esp-rs/esp-idf-template cargo`
- [esp-template](https://github.com/esp-rs/esp-template): `no_std` template.
  - `cargo generate https://github.com/esp-rs/esp-template`

> Be sure to match the installed environment in the selected image tag (esp-idf version and board)

Once in the devcontainer, and with the project ready, search for `TODO` in the project
and update those fields.
- `build.sh`: Update the ESP_BOARD
- `flash.sh`: Update project path, ESP_BOARD and ESP_ELF
- `run-wokwi.sh`: Update project path, ESP_BOARD and ESP_ELF
- `launch.json`: Update executable path and gdb path
# Build
- Terminal approach:

    ```
    ./build.sh  [debug | release]
    ```
    > If no argument is passed, `release` will be used as default


-  UI approach:

    The default build task is already set to build the project, and it can be used
    in VsCode and Gitpod:
    - From the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) (`Ctrl-Shift-P` or `Cmd-Shift-P`) run the `Tasks: Run Build Task` command.
    - `Terminal`-> `Run Build Task` in the menu.
    - With `Ctrl-Shift-B` or `Cmd-Shift-B`.
    - From the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) (`Ctrl-Shift-P` or `Cmd-Shift-P`) run the `Tasks: Run Task` command and
    select `Build`.
    - From UI: Press `Build` on the left side of the Status Bar.

# Flash

- Terminal approach:
  - Using custom `runner` in `.cargo/config.toml`:
    ```
    cargo run [--release]
    ```
    > If using an Xtensa target, use `cargo +esp`
  - Using `flash.sh` script:

    ```
    ./flash.sh [debug | release]
    ```
    > If no argument is passed, `release` will be used as default

- UI approach:
    - From the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) (`Ctrl-Shift-P` or `Cmd-Shift-P`) run the `Tasks: Run Task` command and
    select `Build & Flash`.
    - From UI: Press `Build & Flash` on the left side of the Status Bar.


# Wokwi Simulation

- Terminal approach:

    ```
    ./run-wokwi.sh [debug | release]
    ```
    > If no argument is passed, `release` will be used as default.

- UI approach:

    The default test task is already set to build the project, and it can be used
    in VsCode and Gitpod:
    - From the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) (`Ctrl-Shift-P` or `Cmd-Shift-P`) run the `Tasks: Run Test Task` command
    - With `Ctrl-Shift-,` or `Cmd-Shift-,`
        > Note: This Shortcut is not available in Gitpod by default.
    - From the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) (`Ctrl-Shift-P` or `Cmd-Shift-P`) run the `Tasks: Run Task` command and
    select `Build & Run Wokwi`.
    - From UI: Press `Build & Run Wokwi` on the left side of the Status Bar.

## Debuging with Wokwi

Wokwi offers debugging with GDB.

- Terminal approach:
    ```
    $HOME/.espressif/tools/xtensa-esp32-elf/esp-2021r2-patch3-8.4.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gdb target/xtensa-esp32-espidf/release/brno-public-transport -ex "target remote localhost:9333"
    ```
    > Update the previous command with your toolchain and project elf file.

    > [Wokwi Blog: List of common GDB commands for debugging.](https://blog.wokwi.com/gdb-avr-arduino-cheatsheet/?utm_source=urish&utm_medium=blog)
- UI approach:

    Debug using with VsCode or Gitpod is also possible:
    1. Run the Wokwi Simulation in `debug` profile.
        > Note that the simulation will pause if the browser tab is on the background.
    2. Go to `Run and Debug` section of the IDE (`Ctrl-Shift-D or Cmd-Shift-D`).
    3. Start Debugging (`F5`).
    4. Choose the proper user:
        - `esp` when using VsCode or GitHub Codespaces.
        - `gitpod` when using Gitpod.
# Integrating devcontainer in existing repositories
- For devcontainer support in VSCode and GH Codespaces:
  - Copy the `.devcontainer` folder to your repository.Devcontainers in Gitpod:
- For devcontainer support in Gitpod:
  - Copy the `.gitpod.yml` and `.gitpod.Dockergile` files to your repository.
    - For instructions about how to add a "Open in Gitpod" button, see their
      [official documentation](https://www.gitpod.io/docs/getting-started#open-in-gitpod-button)
- For task and debugging integration:
  - Copy `.vscode` folder.
  - Copy `build.sh`, `flash.sh`, `run-wokwi.sh` files.
After copiying the desired files, go through the [Setup section](#setup)