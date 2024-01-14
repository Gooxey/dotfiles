#!/usr/bin/env bash

function choose() {
    local setting=$1
    shift
    local options=("$@")

    while true; do
        if $can_clear; then clear; fi
        echo "Please choose a $setting."
        echo "The available options are:"

        for i in ${!options[@]}; do
            # First one is default
            tmp=""
            if [ $i == 0 ]; then tmp=" (default)"; fi

            echo "  $i. ${options[$i]}$tmp"
        done

        read -sn 1 tmp

        # Set first option on enter
        if [ -z $tmp ]; then
            eval "$setting=${options[0]}"
            return 0
        fi

        # else read properly
        for i in ${!options[@]}; do
            if [ $i == "$tmp" ]; then
                eval "$setting=${options[$i]}"
                return 0
            fi
        done
    done
}
function choose_two() {
    local var=$1
    local default_yes=$2

    if $default_yes; then
        local description="$3 (Y/n)"
        local default=true
    else
        local description="$3 (y/N)"
        local default=false
    fi

    while true; do
        if $can_clear; then clear; fi
        echo $description
        read -sn 1 tmp

        # Handle enter press
        if [ -z $tmp ]; then
            eval "$var=$default"
            return 0
        fi

        # normal handling
        case $tmp in
        "y" | "Y")
            eval "$var=true"
            return 0 ;;
        "n" | "N")
            eval "$var=false"
            return 0 ;;
        esac
    done
}
function add_command() {
    local cmd=$1
    echo "    $ $cmd"

    if [ -z "$command" ]; then
        command=$cmd
    else
        command="$command && $cmd"
    fi
}
function update_userdata_field() {
    local field=$1
    local value=${!1}

    add_command "sed -e '/$field *= *\"[^\"]*\";/d' -e '$ i\ \ $field = \"$value\";' -i userdata.nix"
}

can_clear=true
command=""

# HOST
choose host \
    "kraken"

# DESKTOP ENVIRONMENT
choose desktop_environment \
    "gnome" \
    "hyprland"

# RICE
case $desktop_environment in
"gnome")
    choose rice \
        "cyberpunk"
;;
"hyprland")
    choose rice \
        "cyberpunk"
;;
esac

# REBOOT
choose_two reboot true "Should this machine be restarted once everthing got configured?"

# EXPORT
choose_two export false "Should the generated command be exported to ./quick_install.sh? Any file at this location will be overriden!"

clear
echo "SUMMARY"
echo "-------"
echo "Host                : $host"
echo "Desktop Environment : $desktop_environment"
echo "Rice                : $rice"
echo "Reboot              : $reboot"
echo "Export              : $export"
echo ""
echo "COMMANDS"
echo "--------"
    echo "Override the current values of the userdata.nix file with the new ones."
    update_userdata_field "host"
    update_userdata_field "desktop_environment"
    update_userdata_field "rice"

    echo "Install the new system and load it and its components."
    add_command "sudo nixos-rebuild switch --flake .#from-userdata "

    case $desktop_environment in
    "hyprland") if ! $reboot; then
        add_command "hyprctl reload"
    fi ;;
    esac

    if $reboot; then
        echo "Reboot the machine."
        add_command "reboot"
    fi
echo ""
echo "SINGLE-LINE-COMMAND"
echo "-------------------"
echo $command
echo ""

can_clear=false
choose_two continue true "Continue?"
if ! $continue; then exit 0; fi

if $export; then echo $command > ./quick_install.sh; fi

eval $command