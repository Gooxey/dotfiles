{ ... }: {
    xdg.configFile = {
        "rofi/bin" = {
            source = ./bin;
            recursive = true;
        };
        "rofi/theme" = {
            source = ./theme;
            recursive = true;
        };
    };
}