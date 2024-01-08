{ inputs, pkgs, userdata, ... }:
let
  host_specific_config = ../../../host/${userdata.host}/hyprland.conf;
in {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./programs
    ./theme.nix
  ];

  home = {
    packages = with pkgs; [
      rofi
      waybar
      swww
      dolphin
      dunst
      polkit-kde-agent
      udiskie
      pavucontrol
    ];
  };

  xdg.configFile."wallpapers/cyberpunk.jpg".source = ../../../assets/wallpapers/cyberpunk.jpg;

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    extraConfig =
      builtins.readFile ./hyprland.conf +
      (
        if builtins.pathExists host_specific_config then
          builtins.readFile host_specific_config
        else
          ""
      )
    ;
  };
}