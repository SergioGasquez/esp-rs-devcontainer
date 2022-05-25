#!/bin/bash

# Gitpod and VsCode Codespaces tasks do not source the user environment
if [ "${USER}" == "gitpod" ]; then
    which idf.py >/dev/null || {
        source ~/export-esp.sh > /dev/null 2>&1
    }
elif [ "${CODESPACE_NAME}" != "" ]; then
    which idf.py >/dev/null || {
        source ~/export-esp.sh > /dev/null 2>&1
    }
fi

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
        cargo "${TOOLCHAIN}" build --target ${ESP_ARCH} --release --features "native"
        ;;
    "debug")
        cargo "${TOOLCHAIN}" build --target ${ESP_ARCH} --features "native"
        ;;
    *)
        echo "Wrong argument. Only \"debug\"/\"release\" arguments are supported"
        exit 1;;
esac