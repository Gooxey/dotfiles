GREY='\e[2;39m'
NC='\033[0m'

command=""

function delete_lines() {
    echo -e "\e[${1}A"
    for ((i = 2; i <= $1; i++)); do
        echo -e "\r\033[K"
    done
    echo -e "\e[${1}A"
}

function confirm_continue() {
    local continue=false

    while true; do
        echo -e "Do you want to run this script? (Y/n)"
        read -sn 1 tmp
        delete_lines 2

        # enter press
        if [ -z $tmp ]; then
            return 0
        fi

        # normal handling
        case $tmp in
        "y" | "Y")
            return 0 ;;
        "n" | "N")
            return 1 ;;
        esac
    done
}

function add_description() {
    local description=$1

    local tmp="echo -e \"> $description\""
    eval $tmp

    if [ -z "$command" ]; then
        command=$tmp
    else
        command="$command && $tmp"
    fi
}

function add_command() {
    local commands=("$@")
    local tmp=""
    
    echo -en $GREY
    
    for cmd in "${commands[@]}"; do
	if [ -z "$final_command" ]; then
	    tmp="$cmd"
	else
	    tmp="$tmp;$cmd"
	fi
        echo "    $ $cmd"
    done
    
    echo -en $NC
    
    if [ -z "$command" ]; then
        command=$tmp
    else
        command="$command && $tmp"
    fi
}

cd config

echo "Commands"
echo "--------"

add_description "Delete exiting files which are in the way of the new dotfiles"
    for dir in *; do
        add_command "rm -rf ~/.config/$dir"
    done

add_description "Create links to this repos dotfiles"
    for dir in *; do
        full_dir=$(realpath $dir)
        add_command "ln -s $full_dir ~/.config"
    done

echo
echo "Make sure to backup your files!"
echo

if ! confirm_continue; then exit 0; fi

cd ..

eval $command
