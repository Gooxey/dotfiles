{
  pkgs,
  username,
  stateVersion,
  ...
}:
{
  imports = [
    ./boot.nix
    ./nix.nix
    ./sound.nix
    ./locale.nix
  ];

  # use the latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # allow running dynamically linked executables
  programs.nix-ld.enable = true;

  # allow running http server as normal user
  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 0;

  programs.gamemode.enable = true;
  networking.networkmanager.enable = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # printer/scanner
  services = {
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  hardware.sane = {
    enable = true;
    disabledDefaultBackends = [ "escl" ];
    extraBackends = [
      pkgs.sane-airscan
    ];
  };

  programs.ausweisapp = {
    enable = true;
    openFirewall = true;
  };

  programs.adb.enable = true;

  system = {
    inherit stateVersion;
    # automatic updates
    autoUpgrade = {
      enable = true;
      dates = "daily";
    };
  };

  users.users."${username}" = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "scanner"
      "lp"
      "dialout"
      "adbusers"
      "plugdev"
    ];
  };
}
