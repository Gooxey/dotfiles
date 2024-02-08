{ pkgs, ... }: {
    home.packages = [ pkgs.kitty ];
    programs.kitty = {
        enable = true;
        settings = {
            confirm_os_window_close = 2;
        };
    };
}