#!/usr/bin/env bash

. common.sh

require_sudo "\
Sudo privileges are required to rebuild your system.\n\
To check which commands will run with sudo privileges, proceed until you reach the summary screen.
"

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

    local message_line_count=$(echo -e "$message" | wc -l)
    local lines_to_delete=$(($message_line_count + 1))

    while true; do
        echo -e $description
        read -sn 1 tmp

        # Handle enter press
        if [ -z $tmp ]; then
            eval "$var=$default"
            delete_lines $lines_to_delete
            return 0
        fi

        # normal handling
        case $tmp in
        "y" | "Y")
            eval "$var=true"
            delete_lines $lines_to_delete
            return 0 ;;
        "n" | "N")
            eval "$var=false"
            delete_lines $lines_to_delete
            return 0 ;;
        esac

        delete_lines $lines_to_delete
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

    add_command "sed -e '/$field *= *\"[^\"]*\";/d' -e '$ i\ \ \ \ $field = \"$value\";' -i ./userdata.nix"
}

command=""

# HOST
menu host \
    "Please choose a host." \
        "kraken"

# DESKTOP ENVIRONMENT
menu desktop_environment \
    "Please choose a desktop environment." \
        "gnome" \
        "hyprland"

# RICE
case $desktop_environment in
"gnome")
    menu rice \
        "Please choose a rice." \
            "cyberpunk"
;;
"hyprland")
    menu rice \
        "Please choose a rice." \
            "cyberpunk"
;;
esac

# REBOOT
choose_two reboot true "Should this machine be restarted once everthing got configured?"

# EXPORT
choose_two export false "Should the generated command be exported to ./quick_install.sh? Any file at this location will be overriden!"

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

choose_two continue true "Continue?"
if ! $continue; then exit 0; fi

echo "COMMAND-OUTPUT"
echo "--------------"

cd ..
if $export; then echo $command > ./quick_install.sh; fi
eval $command