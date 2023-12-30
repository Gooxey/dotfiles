machine() {
    while true; do
        echo ""
        echo "Please choose a machine"
        echo "The available options are: (1-2)"
        echo "  1. kraken (default)"
        echo "  2. vm"

        read -s -n 1 input

        case $input in
        "1" | "") machine="kraken" ;;
        "2") machine="vm" ;;
        esac
            
        break
    done
}

desktop_enviroment() {
    while true; do
        echo ""
        echo "Please choose a desktop enviroment"
        echo "The available options are:"
        echo "  1. gnome (default)"

        read -s -n 1 input

        case $input in
        "1" | "") desktop_enviroment="gnome" ;;
        esac
            
        break
    done
}

gnome_rice() {
    while true; do
        echo ""
        echo "Please choose a rice"
        echo "The available options are:"
        echo "  1. cyberpunk (default)"

        read -s -n 1 input

        case $input in
        "1") rice="cyberpunk" ;;
        esac
            
        break
    done
}

ask_reboot() {
    while true; do
        echo ""
        echo "Reboot when done? (Y/n)"
        read -s -n 1 input

        case $input in
        "n") reboot=false ;;
        "y" | "") ;;
        *) continue ;;
        esac

        break
    done
}

ask_continue() {
    while true; do
        echo "Continue? (Y/n)"
        read -s -n 1 input

        case $input in
        "n") exit 0 ;;
        "y" | "") break ;;
        *) continue ;;
        esac
    done
}

machine="kraken"
machine

desktop_enviroment="gnome"
desktop_enviroment

case $desktop_enviroment in
"gnome")
    rice="cyberpunk"
    gnome_rice
;;
esac

reboot=true
ask_reboot

combination="$machine-$desktop_enviroment-$rice"

echo ""
echo ""
echo "SUMMARY"
echo "-------"
echo "Combination : $combination"
echo "Reboot      : $reboot"
echo ""
echo "COMMANDS"
echo "--------"
echo "$ sudo nixos-rebuild switch --flake .#$combination --upgrade-all"
if $reboot; then echo "$ reboot"; fi
echo ""

ask_continue

sudo nixos-rebuild switch --flake .#$combination --upgrade-all
if $reboot; then
    reboot
fi