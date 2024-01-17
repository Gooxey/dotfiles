#! /usr/bin/env bash

clear
echo "How should your machine be called?"
read host

# paths
host_dir="host/$host"
hyprland_dir=$host_dir/hyprland

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
start_line=$(grep -n "choose host \\\\" install.sh | cut -d: -f1)

current_line=$((start_line + 1))
while [[ $(sed -n "${current_line}p" install.sh) == *"\\" ]]; do
    ((current_line++))
done

sed -i "$current_line s/$/ \\\\/" install.sh
sed -i "$current_line a\    \"$host\"" install.sh
