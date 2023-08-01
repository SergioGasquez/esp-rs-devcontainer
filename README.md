# esp-rs-devcontainer

> **Warning**
>
> This repository is outdated and was only an initial PoC. If you want to use
> DevContainers in esp-rs, see
> [Using Dev Containers in the templates](https://esp-rs.github.io/book/writing-your-own-application/generate-project/index.html#using-dev-containers-in-the-templates)
> section of The Rust on ESP Book.


This repository offers template Dockerfiles for [Dev Containers](https://code.visualstudio.com/docs/remote/containers), with the
environment needed to develop applications for [ESP boards using Rust](https://github.com/esp-rs),
in VS Code, [Gitpod](https://www.gitpod.io/) and [GitHub Codespaces](https://docs.github.com/es/codespaces/developing-in-codespaces).

For instructions on how to integrate devcontainers to existing repositories, see
[this section](#integrating-devcontainer-in-existing-repositories).

This repository is can be used as template repository.

# Starting a new project
Using [cargo-generate](https://github.com/cargo-generate/cargo-generate) with one
of the available tempaltes is the recommended way to start new projects:
- [esp-idf-template](https://github.com/esp-rs/esp-idf-template): ESP-IDF Template
  - `cargo generate --vcs none --git https://github.com/esp-rs/esp-idf-template cargo`
- [esp-template](https://github.com/esp-rs/esp-template): `no_std` template.
  - `cargo generate https://github.com/esp-rs/esp-template`

See [project section of awesome-esp-rust](https://github.com/esp-rs/awesome-esp-rust#projects) for inspiration in other projects


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

## Setup
The repository supports:
-  [Gitpod](https://gitpod.io/)
   - ["Open in Gitpod" button](https://www.gitpod.io/docs/getting-started#open-in-gitpod-button)
-  [Vs Code Devcontainers](https://code.visualstudio.com/docs/remote/containers#_quick-start-open-an-existing-folder-in-a-container)
-  [GitHub Codespaces](https://docs.github.com/en/codespaces/developing-in-codespaces/creating-a-codespace)
    > **Note**
    >
    > In [order to use GitHub Codespaces](https://github.com/features/codespaces#faq)
    > the project needs to be published in a GitHub repository and the user needs
    > to be part of the Codespaces beta or have the project under an organization.
    >
    > When using GitHub Codespaces, we need to make the ports
    > public, [see instructions](https://docs.github.com/en/codespaces/developing-in-codespaces/forwarding-ports-in-your-codespace#sharing-a-port).

If using VS Code or GitHub Codespaces, you can pull the image instead of building it
from the Dockerfile by selecting the `image` property instead of `build` in
`.devcontainer/devcontainer.json`. Further customization of the Dev Container can
be achived, see [.devcontainer.json reference](https://code.visualstudio.com/docs/remote/devcontainerjson-reference).

Before opening the Dev Container, address all the ToDos by searching for `TODO` in the project
and update those fields.
- `build.sh`: Update the ESP_BOARD
- `flash.sh`: Update project path, ESP_BOARD and ESP_ELF
- `run-wokwi.sh`: Update project path, ESP_BOARD and ESP_ELF
- `launch.json`: Update executable path and GDB path

By now, the Dev Container should be ready to run and the environment should be ready
to use.
## Build
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

## Flash

- Terminal approach:
  - Using `flash.sh` script:

    ```
    ./flash.sh [debug | release]
    ```
    > If no argument is passed, `release` will be used as default

- UI approach:
    - From the [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette) (`Ctrl-Shift-P` or `Cmd-Shift-P`) run the `Tasks: Run Task` command and
    select `Build & Flash`.
    - From UI: Press `Build & Flash` on the left side of the Status Bar.


## Wokwi Simulation

> **Warning**
>
>  ESP32-S3 is not available in Wokwi

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

### Debuging with Wokwi

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
