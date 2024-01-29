echo "Wont work"
exit 1

lsblk

echo ""
echo "Select a device to install NixOS to: /dev/sd<input>"

read tmp
device="/dev/sd$tmp"

echo "Should $device be formatted? (yes/no)"
read tmp
if [ "$tmp" != "yes" ]; then
    echo "Installation cancelled by user"
    exit 0
fi

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo fdisk $device
	g
	n
	1
	2048
	+500M
	t
	1
	n
	2
	
	
	w
EOF

sudo mkfs.fat -F 32 ${device}1
sudo fatlabel ${device}1 NIXBOOT
sudo mkfs.ext4 ${device}2 -L NIXROOT

sudo mount /dev/disk/by-label/NIXROOT /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot
