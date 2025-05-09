{ pkgs
, username
, stateVersion
, ...
}:
{
  imports = [
    ./nixvim
    ./bash.nix
    ./fonts.nix
    ./git.nix
    ./syncthing.nix
    ./alacritty.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # let home manager install and manage itself
  programs.home-manager.enable = true;
  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "daily";
  };

  home = {
    inherit username stateVersion;
    homeDirectory = "/home/${username}";

    packages = with pkgs; [
      brave
      obsidian
      spotify
      vlc
      feishin

      usbimager
      keepassxc

      steam
      heroic
      bottles
      lutris
      prismlauncher
      sidequest
    ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
