#! /usr/bin/env bash

. common.sh

cd ..

echo "How should your machine be called?"
read host

# paths
rebuild_sript=".script/rebuild.sh"
host_dir="host/$host"
hyprland_dir=$host_dir/hyprland

# exit if host already exists
if [ -d "$host_dir" ]; then
    delete_lines 3
    echo -e "${RED}The host \`$host\` is already registered."
    echo -e "Check the \`host\` directory for all registered hosts.${NC}"
    exit 1
fi

# create directorys
mkdir -p $host_dir/hyprland

# Create default files
echo "# Add your machine specific config here. ( For example a monitor configuration )" > $hyprland_dir/hyprland.conf
echo "{
    persistent-workspaces = {
        # see https://github.com/Alexays/Waybar/wiki/Module:-Hyprland#persistent-workspaces
        \"*\" = 10;
    };
}" > $hyprland_dir/waybar.nix

# generate hardware-config
nixos-generate-config --show-hardware-config > $host_dir/default.nix

# Add this machine to the install script
start_line=$(grep -n "menu host \\\\" $rebuild_sript | cut -d: -f1)

current_line=$((start_line + 1))
while [[ $(sed -n "${current_line}p" $rebuild_sript) == *"\\" ]]; do
    ((current_line++))
done

sed -i "$current_line s/$/ \\\\/" $rebuild_sript
sed -i "$current_line a\        \"$host\"" $rebuild_sript
