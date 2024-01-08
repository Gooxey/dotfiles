{ inputs, pkgs, userdata, ... }: {
  imports = [
    ./fonts.nix
    inputs.hyprland.nixosModules.default
  ];

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  # display manager
  services.greetd = {
    enable = true;
    restart = false;
    settings = rec {
      initial_session = {
        command = "Hyprland &> /dev/null";
        user = userdata.user;
      };
      default_session = initial_session;
    };
  };
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];
}