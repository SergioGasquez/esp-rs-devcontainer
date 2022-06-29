#!/bin/bash

# Gitpod and VsCode Codespaces tasks do not source the user environment
# TODO: Update project path
if [ "${USER}" == "gitpod" ]; then
    export CURRENT_PROJECT=/workspace/your-project-name
    which idf.py >/dev/null || {
        source ~/export-esp.sh > /dev/null 2>&1
    }
elif [ "${CODESPACE_NAME}" != "" ]; then
    export CURRENT_PROJECT=/workspaces/your-project-name
    which idf.py >/dev/null || {
        source ~/export-esp.sh > /dev/null 2>&1
    }
else
    export CURRENT_PROJECT=~/workspace/your-project-name
fi

cd $CURRENT_PROJECT

# TODO: Update ESP_BOARD
export ESP_BOARD="esp32"
export TOOLCHAIN=""
if [ "${ESP_BOARD}" == "esp32c3" ]; then
    export TOOLCHAIN=""
    export ESP_ARCH="riscv32imc-esp-espidf"
elif [ "${ESP_BOARD}" == "esp32s2" ]; then
    export TOOLCHAIN="+esp"
    export ESP_ARCH="xtensa-esp32s2-espidf"
elif [ "${ESP_BOARD}" == "esp32s3" ]; then
    export TOOLCHAIN="+esp"
    export ESP_ARCH="xtensa-esp32s3-espidf"
else
    export TOOLCHAIN="+esp"
    export ESP_ARCH="xtensa-esp32-espidf"
fi

case "$1" in
    ""|"release")
        cargo "${TOOLCHAIN}" build --target ${ESP_ARCH} --release
        ;;
    "debug")
        cargo "${TOOLCHAIN}" build --target ${ESP_ARCH}
        ;;
    *)
        echo "Wrong argument. Only \"debug\"/\"release\" arguments are supported"
        exit 1;;
esac
