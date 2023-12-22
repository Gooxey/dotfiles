{ pkgs, ... }: {
  imports = [
    ../xserver.nix
  ];
  
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "dennis";
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # exclude gnomes bloat
  environment.gnome.excludePackages = with pkgs.gnome; [
    baobab
    # cheese
    # eog
    epiphany
    gedit
    simple-scan
    totem
    yelp
    evince
    # file-roller
    geary
    # seahorse

    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    # gnome-photos
    # gnome-screenshot
    # gnome-system-monitor
    gnome-weather
    gnome-disk-utility
    gnome-terminal
    pkgs.gnome-tour
    pkgs.gnome-connections
  ];
}