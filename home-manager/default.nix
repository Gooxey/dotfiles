{ pkgs, lib, stateVersion, userdata, ... }: let
    programs = programs: lib.lists.forEach programs (
        program: ./programs/${program}
    );
in {
    imports = [
        ../desktop-environment/${userdata.desktop_environment}/home-manager
        # ./programs
    ] ++ programs [
        "git"
        "kitty"
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
            gnome.nautilus

            brave
            spotify
            obsidian

            neovim
            gh
            vscode

            eza
            btop
        ];
    };
}