{ userdata, lib, ... }:
let
  primary_display_path = ../../../../../host/${userdata.host}/primary-display;
  primary_display = (
    if builtins.pathExists primary_display_path then
      [ (builtins.readFile primary_display_path) ]
    else
      []
  );
in {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ./style.css;
    settings = [{
      output = primary_display;

      layer = "top";
      position = "top";
      modules-left = [
        "clock#calendar"
        "clock"
      ];
      modules-right = [
        "tray"
        "pulseaudio"
        "network"
        "custom/powermenu"
      ];

      "clock#calendar" = {
        format = "{:%d.%m.%Y}";
        tooltip = true;
        tooltip-format= "<tt>{calendar}</tt>";
        calendar = {
          mode = "year";
          mode-mon-col = 3;
          weeks-pos = "right";
          on-scroll = 1;
          on-click-right = "mode";
          format = {
            months   = "<span color='#ffead3'><b>{}</b></span>";
            days     = "<span color='#ecc6d9'><b>{}</b></span>";
            weeks    = "<span color='#99ffdd'><b>W{}</b></span>";
            weekdays = "<span color='#ffcc66'><b>{}</b></span>";
            today    = "<span color='#ff6699'><b><u>{}</u></b></span>";
          };
          actions = {
            on-click-right = "mode";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
      };
      "clock" = {
        format = "<span color='#fbf1c7'> </span>{:%H:%M}";
        tooltip = false;
      };

      "tray" = {
        icon-size = 20;
        spacing = 9;
        show-passive-items = true;
      };
      "pulseaudio" = {
        scroll-step = 1;
        format = "<span color='#fbf1c7'>{icon}</span> {volume}%";
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
        format-wifi = "<span color='#fbf1c7'> </span>{essid}";
        format-ethernet = "󰈀";
        format-disconnected = "<span color='#fbf1c7'>󰖪 </span>No Network";
        interval = 1;
        tooltip = true;
      };
      "custom/powermenu" = {
        format = " ⏻ ";
        on-click = "pkill rofi || bash ~/.config/rofi/bin/powermenu.sh";
        tooltip = false;
      };
    }];
  };
}