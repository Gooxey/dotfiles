{ pkgs, userdata, ... }: {
    # Workaround for GNOME autologin
    systemd.services = {
        "getty@tty1".enable = false;
        "autovt@tty1".enable = false;
    };

    services.xserver = {
        enable = true;

        # layout
        layout = "de";
        xkbVariant = "";

        # Enable the GNOME Desktop Environment
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;

        # Enable automatic login for the user
        displayManager.autoLogin = {
            enable = true;
            user = userdata.user;
        };
    };

    # exculde gnome bloat
    environment.gnome.excludePackages = with pkgs.gnome; [
        baobab
        # cheese
        # eog
        epiphany
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
        # gnome-sceenshot
        gnome-system-monitor
        gnome-weather
        gnome-disk-utility
        gnome-terminal
        pkgs.gnome-tour
        pkgs.gnome-connections
        pkgs.gedit
    ];
}