{ pkgs, userdata, ... }: rec {
    home.file.".themes/Cyberpunk/gnome-shell/gnome-shell.css".source = ./gnome-shell.css;
    xdg.configFile."wallpapers/cyberpunk.jpg".source = ../../../assets/wallpapers/cyberpunk.jpg;

    home.packages = with pkgs.gnomeExtensions; [
        pop-shell
        app-icons-taskbar
        top-bar-organizer
        user-themes
    ];

    dconf.settings = {
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
        "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";

        # shortcuts
        "org/gnome/desktop/wm/preferences".mouse-button-modifier = "<Alt>";

        # Enable installed extensions
        "org/gnome/shell".enabled-extensions = (map (extension: extension.extensionUuid) home.packages) ++ ["user-theme@gnome-shell-extensions.gcampax.github.com"];
        "org/gnome/shell".disabled-extensions = [];

        # Configure style
        "org/gnome/shell/extensions/user-theme".name = "Cyberpunk";
        "org/gnome/desktop/background" = {
            picture-uri = "/home/${userdata.user}/.config/wallpapers/cyberpunk.jpg";
            picture-uri-dark = "/home/${userdata.user}/.config/wallpapers/cyberpunk.jpg";
            picture-options = "zoom";
        };

        # Configure pop shell
        "org/gnome/mutter".edge-tiling = false;
        "org/gnome/shell/extensions/pop-shell" = {
            tile-by-default = true;
            active-hint = false;
            active-hint-border-radius = 5;
            gap-inner = 2;
            gap-outer = 2;
        };

        # Configure app-icons-taskbar
        "org/gnome/shell/extensions/aztaskbar" = {
            dance-urgent = true;
            favorites = true;
            icon-size = 24;
            icon-style = "REGULAR";
            indicator-location = "TOP";
            isolate-monitors = false;
            isolate-workspaces = true;
            main-panel-height = [ "false" "36" ];
            multi-window-indicator-style = "MULTI_DASH";
            notification-badges = false;
            panel-location = "TOP";
            panel-on-all-monitors = false;
            position-offset = 0;
            show-apps-button = [ "false" "0" ];
            show-panel-activities-button = false;
            show-panel-appmenu-button = false;
            show-running-apps = true;
            unity-badges = true;
            unity-progress-bars = true;
        };
        "org/gnome/shell".favorite-apps = [
            "brave-browser.desktop"
            "spotify.desktop"
            "org.gnome.Nautilus.desktop"
        ];
    };
}