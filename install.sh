RED='\033[1;31m'
GREY='\e[2;39m'
NC='\033[0m'

[[ ! $EUID -ne 0 ]] && echo -e "${RED}Do not execute this script using sudo! Run this instead:\n  \$ bash install.sh$NC" && exit 1

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

if [ ! -d generated ]; then
    add_description "Create the generated dir and prepare the uninstall script"
        add_command "rm -rf generated"
        add_command "mkdir generated"
        add_command 'DOTFILES_UNINSTALL_SCRIPT=""'
fi

for dir in *; do
    full_dir=$(realpath $dir)
    add_description "Override files at ~/.config/$dir with a link to this repos dotfiles and add the link to the uninstall srcipt"
        add_command "rm -rf ~/.config/$dir"
        add_command "ln -s $full_dir ~/.config"
        add_command "DOTFILES_UNINSTALL_SCRIPT=\"\$DOTFILES_UNINSTALL_SCRIPT && rm ~/.config/$dir\""
done

add_description "Install neovim nightly and add it to the uninstall script"
    add_command 'curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > generated/nvim'
    add_command 'chmod u+x generated/nvim'
    add_command "sudo rm -f /usr/bin/nvim"
    add_command 'sudo ln -s $(realpath ./generated/nvim) /usr/bin'
    add_command 'DOTFILES_UNINSTALL_SCRIPT="$DOTFILES_UNINSTALL_SCRIPT && rm /usr/bin/nvim"'

add_description "Finish and write the uninstall script to generated/uninstall.sh"
    add_command 'DOTFILES_UNINSTALL_SCRIPT="$DOTFILES_UNINSTALL_SCRIPT && rm -rf ../generated"'
    add_command 'echo $DOTFILES_UNINSTALL_SCRIPT > generated/uninstall.sh'
    add_command 'chmod +x generated/uninstall.sh'

echo
echo "Make sure to backup your files!"
echo

if ! confirm_continue; then exit 0; fi

cd ..

eval $command
