{ pkgs, lib, stateVersion, userdata, ... }: {
  imports = [
    ../desktop-environment/${userdata.desktop_environment}/home-manager
  ];

  # automatic updates
  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "daily";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home = {
    inherit stateVersion;

    username = userdata.user;
    homeDirectory = "/home/${userdata.user}";

    packages = with pkgs; [
      kitty

      # not sure about the file manager yet
      dolphin
      gnome.nautilus

      brave
      spotify
      obsidian

      vscode
      neovim
      git
      gh

      eza
      btop
    ];
  };


  programs = {
    git = {
      enable =  true;
      userEmail = "dennis.tiderko@gmail.com";
      userName = "Gooxey";
    };
  };
}