#!/usr/bin/env bash

cd .script

. common.sh

menu_numbered_return operation \
    "What do you want to do?" \
        "Add a new machine" \
        "Rebuild my system"

case $operation in
0) bash new_machine.sh ;;
1) bash rebuild.sh ;;
esac
