#!/usr/bin/env bash

set -e

# TODO: Update project path
if [ "${USER}" == "gitpod" ]; then
    export CURRENT_PROJECT=/workspace/your-project-name
elif [ "${CODESPACE_NAME}" != "" ]; then
    export CURRENT_PROJECT=/workspaces/your-project-name
else
    export CURRENT_PROJECT=~/workspace/your-project-name
fi

BUILD_MODE=""
case "$1" in
    ""|"release")
        bash build.sh
        BUILD_MODE="release"
        ;;
    "debug")
        bash build.sh debug
        BUILD_MODE="debug"
        ;;
    *)
        echo "Wrong argument. Only \"debug\"/\"release\" arguments are supported"
        exit 1;;
esac

# TODO: Update ESP_BOARD and ESP_ELF
export ESP_BOARD="esp32"
export ESP_ELF="your-project-name"

if [ "${ESP_BOARD}" == "esp32c3" ]; then
    export ESP_ARCH="riscv32imc-esp-espidf"
elif [ "${ESP_BOARD}" == "esp32s2" ]; then
    export ESP_ARCH="xtensa-esp32s2-espidf"
elif [ "${ESP_BOARD}" == "esp32s3" ]; then
    export ESP_ARCH="xtensa-esp32s3-espidf"
else
    export ESP_ARCH="xtensa-esp32-espidf"
fi

web-flash --chip ${ESP_BOARD} ${CURRENT_PROJECT}/target/${ESP_ARCH}/${BUILD_MODE}/${ESP_ELF}
