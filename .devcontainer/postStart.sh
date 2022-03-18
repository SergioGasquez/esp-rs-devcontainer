#! /usr/bin/env bash
function ask_config() {
    PS3='Please choose your MCU: '
    options=("esp32" "esp32s2" "esp32s3" "esp32c3")
    select opt in "${options[@]}"
    do
        case $opt in
            "esp32")
                echo "you chose choice $REPLY which is $opt"
                mcu=esp32
                break
                ;;
            "esp32s2")
                echo "you chose choice $REPLY which is $opt"
                mcu=esp32s2
                break
                ;;
            "esp32s3")
                echo "you chose choice $REPLY which is $opt"
                mcu=esp32s3
                break
                ;;
            "esp32c3")
                echo "you chose choice $REPLY which is $opt"
                mcu=esp32c3
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
    clear
    PS3='Please choose your ESP-IDF native build version (v4.3.2 = previous stable, v4.4 = stable, v5.0 = development; NOTE: applicable only with `cargo build --features native`): '
    options=("v4.3.2" "v4.4" "v5.0")
    select opt in "${options[@]}"
    do
        case $opt in
            "v4.3.2")
                echo "you chose choice $REPLY which is $opt"
                idf_version=v4.3.2
                break
                ;;
            "v4.4")
                echo "you chose choice $REPLY which is $opt"
                idf_version=v4.4
                break
                ;;
            "v5.0")
                echo "you chose choice $REPLY which is $opt"
                idf_version=v5.0
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done

    PS3='Please choose your Rust toolchain (beware: nightly works only for esp32c3!): '
    options=("esp" "nigthly")
    select opt in "${options[@]}"
    do
        case $opt in
            "esp")
                echo "you chose choice $REPLY which is $opt"
                rust_toolchain=esp
                break
                ;;
            "nigthly")
                echo "you chose choice $REPLY which is $opt"
                rust_toolchain=nigthly
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
    # echo "export MCU=$mcu" >> env.sh
    # echo "export IDF_VERSION=$idf_version" >> env.sh
    # echo "export RUST_TOOLCHAIN=$rust_toolchain" >> env.sh
}

function ask_project_details() {
    PS3='Please choose if you would like STD support: '
    options=("true" "false")
    select opt in "${options[@]}"
    do
        case $opt in
            "true")
                echo "you chose choice $REPLY which is $opt"
                std_support=true
                break
                ;;
            "false")
                echo "you chose choice $REPLY which is $opt"
                std_support=false
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done

    PS3='Please choose if you would like version control: '
    options=("git" "none")
    select opt in "${options[@]}"
    do
        case $opt in
            "git")
                echo "you chose choice $REPLY which is $opt"
                vcs=git
                break
                ;;
            "none")
                echo "you chose choice $REPLY which is $opt"
                vcs=none
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
    echo Please choose your project name:
    read project_name
    echo "export STD_SUPPORT=$std_support" >> env.sh
    echo "export VCS=$vcs" >> env.sh
    echo "export PROJECT_NAME=$project_name" >> env.sh
    cargo generate --vcs $vcs --git https://github.com/esp-rs/esp-idf-template cargo --name $project_name --define mcu=$mcu --define toolchain=$rust_toolchain --define espidfver=$idf_version --define std=$std_support 
}

FILE=/home/vscode/dev/env.sh
if test -f "$FILE"; then
    echo "File found"
    # while IFS= read -r line
    # do
    #     echo "$line"
    # done < "$FILE"
    # source /home/vscode/dev/env.sh
else
    echo "No file found"
    PS3='Would you like to start with a template project?'
    options=("yes" "no")
    select opt in "${options[@]}"
    do
        case $opt in
            "yes")
                echo "you chose choice $REPLY which is $opt"
                ask_config
                ask_project_details
                break
                ;;
            "no")
                echo "you chose choice $REPLY which is $opt"
                ask_config
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
fi