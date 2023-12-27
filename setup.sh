machine() {
    echo "Please choose a machine"
    echo "The available options are: (1-2)"
    echo "  1. vm (default)"
    echo "  2. kraken"

    read input

    case $input in
    "1") machine="vm" ;;
    "2") machine="kraken" ;;
    esac
}

desktop_enviroment() {
    echo "Please choose a desktop enviroment"
    echo "The available options are:"
    echo "  1. gnome (default)"

    read input

    case $input in
    "1") desktop_enviroment="gnome" ;;
    esac
}

gnome_rice() {
    echo "Please choose a rice"
    echo "The available options are:"
    echo "  1. cyberpunk (default)"

    read input

    case $input in
    "1") rice="cyberpunk" ;;
    esac
}


machine="vm"
machine

desktop_enviroment="gnome"
desktop_enviroment

case $desktop_enviroment in
"gnome")
    rice="cyberpunk"
    gnome_rice
;;
esac

combination="$machine-$desktop_enviroment-$rice"

echo ""
echo "Building machine $combination..."
echo ""

echo "$ sudo nixos-rebuild switch --flake .#$combination --upgrade-all"
sudo nixos-rebuild switch --flake .#$combination --upgrade-all