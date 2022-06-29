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


if [ "${USER}" == "gitpod" ];then
    gp_url=$(gp url 9012)
    echo "gp_url=${gp_url}"
    export WOKWI_HOST=${gp_url:8}
elif [ "${CODESPACE_NAME}" != "" ];then
    export WOKWI_HOST=${CODESPACE_NAME}-9012.githubpreview.dev
fi

# TODO: Update ESP_BOARD and ESP_ELF
export ESP_BOARD="esp32"
export ESP_ELF="your-project-name"

export WOKWI_PROJECT_ID="332616143815574099"
if [ "${ESP_BOARD}" == "esp32c3" ]; then
    export ESP_ARCH="riscv32imc-esp-espidf"
    export WOKWI_PROJECT_ID=""
elif [ "${ESP_BOARD}" == "esp32s2" ]; then
    export WOKWI_PROJECT_ID=""
    export ESP_ARCH="xtensa-esp32s2-espidf"
else
    export WOKWI_PROJECT_ID="332616143815574099"
    export ESP_ARCH="xtensa-esp32-espidf"
fi

wokwi-server --chip ${ESP_BOARD} --id ${WOKWI_PROJECT_ID} ${CURRENT_PROJECT}/target/${ESP_ARCH}/${BUILD_MODE}/${ESP_ELF}
