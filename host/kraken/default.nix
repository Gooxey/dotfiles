{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../_hardware-specific/nvidia.nix
  ];

  boot = {
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];

    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
      kernelModules = [ ];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/fe6a4142-332e-4b24-adff-86938df66a50";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/5318-E64B";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp34s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
