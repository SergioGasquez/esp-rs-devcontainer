FROM sergiogasquez/esp-rs-env:esp32c3
USER root
RUN _g="/home/gitpod"; usermod -d $HOME $_g -m esp && ln -s $_g $HOME