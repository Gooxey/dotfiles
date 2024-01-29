#! /usr/bin/env bash

RED='\033[1;31m'
NC='\033[0m'

function require_sudo() {
    [[ $EUID -ne 0 ]] && echo -e "$RED$1$NC" && exit 1
}

function delete_lines() {
    echo -e "\e[${1}A"
    for ((i = 2; i <= $1; i++)); do
        echo -e "\r\033[K"
    done
    echo -e "\e[${1}A"
}

function menu_numbered_return() {
    local setting=$1
    local message=$2
    shift
    shift
    local options=("$@")

    local message_line_count=$(echo -e "$message" | wc -l)
    local items_count=${#options[@]}
    local lines_to_delete=$(($items_count + $message_line_count + 2))

    while true; do
        echo -e "$message"
        echo -e "\e[2;39m> Type the number of your item or press enter to select the default option.\e[0m"

        for i in ${!options[@]}; do
            # First one is default
            tmp=""
            if [ $i == 0 ]; then tmp=" (default)"; fi

            echo "  $i. ${options[$i]}$tmp"
        done

        read -sn 1 tmp

        # Set first option on enter
        if [ -z $tmp ]; then
            eval "$setting=0"
            delete_lines $lines_to_delete
            return 0
        fi

        # else read properly
        for i in ${!options[@]}; do
            if [ $i == "$tmp" ]; then
                eval "$setting=$i"
                delete_lines $lines_to_delete
                return 0
            fi
        done

        delete_lines $lines_to_delete
    done
}

function menu() {
    local setting=$1
    shift
    local input=("$@")
    shift
    local options=("$@")

    menu_numbered_return selected_item "${input[@]}"

    for i in ${!options[@]}; do
        if [ $i == "$selected_item" ]; then
            eval "$setting=\"${options[$i]}\""
            return 0
        fi
    done
}