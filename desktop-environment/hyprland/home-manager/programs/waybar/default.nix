{ userdata, lib, config, ... }:
let
    persistent-workspaces = (import ../../../../../host/${userdata.host}/hyprland/waybar.nix).persistent-workspaces;
    color-palette = config.colorScheme.colors;
    colors = ''
        /* https://github.com/chriskempson/base16/blob/main/styling.md */

        @define-color background #${color-palette.base00};
        @define-color mantle #${color-palette.base01};
        @define-color surface0 #${color-palette.base02};
        @define-color surface1 #${color-palette.base03};
        @define-color surface2 #${color-palette.base04};
        @define-color text #${color-palette.base05};
        /* Light Foreground (Not often used) */
        @define-color base06 #${color-palette.base06};
        /* Light Background (Not often used) */
        @define-color base07 #${color-palette.base07};
        /* Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted */
        @define-color base08 #${color-palette.base08};
        /* Integers, Boolean, Constants, XML Attributes, Markup Link Url */
        @define-color base09 #${color-palette.base09};
        /* Classes, Markup Bold, Search Text Background */
        @define-color base0A #${color-palette.base0A};
        /* Strings, Inherited Class, Markup Code, Diff Inserted */
        @define-color base0B #${color-palette.base0B};
        /* Support, Regular Expressions, Escape Characters, Markup Quotes */
        @define-color base0C #${color-palette.base0C};
        /* Functions, Methods, Attribute IDs, Headings */
        @define-color base0D #${color-palette.base0D};
        /* Keywords, Storage, Selector, Markup Italic, Diff Changed */
        @define-color base0E #${color-palette.base0E};
        /* Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?> */
        @define-color base0F #${color-palette.base0F};
    '';
in {
    programs.waybar = {
        enable = true;
        style = colors + "\n" + builtins.readFile ./style.css;
        settings = [{
            layer = "top";
            position = "top";
            modules-left = [
                "hyprland/workspaces"
            ];
            modules-center = [
                "clock"
                "clock#calendar"
            ];
            modules-right = [
                "tray"
                "pulseaudio"
                "network"
                "custom/powermenu"
            ];

            "hyprland/workspaces" = {
                inherit persistent-workspaces;
            };
            "clock#calendar" = {
                format = "{:%d.%m.%Y}";
                tooltip = false;
            };
            "clock" = {
                format = "<span color='#${color-palette.base05}'> </span>{:%H:%M}";
                tooltip = false;
            };

            "tray" = {
                icon-size = 20;
                spacing = 9;
                show-passive-items = true;
            };
            "pulseaudio" = {
                scroll-step = 1;
                format = "<span color='#${color-palette.base05}'>{icon}</span> {volume}%";
                format-muted = "";
                format-icons = {
                    headphone = "";
                    hands-free = "";
                    headset = "";
                    phone = "";
                    portable = "";
                    car = "";
                    default = ["" "" ""];
                };
                on-click = "pavucontrol";
                tooltip = false;
            };
            "network" = {
                format-wifi = "<span color='#${color-palette.base05}'> </span>{essid}";
                format-ethernet = "󰈀";
                format-disconnected = "<span color='#${color-palette.base05}'>󰖪 </span>No Network";
                interval = 1;
                tooltip = false;
            };
            "custom/powermenu" = {
                format = " ⏻ ";
                on-click = "pkill rofi || bash ~/.config/rofi/bin/powermenu.sh";
                tooltip = false;
            };
        }];
    };
}