{ config, pkgs, stateVersion, user, desktop_enviroment, lib, rice, ... }:
let
  rice_path = ../home-manager/rice/${desktop_enviroment}/${rice};
in {
  imports = [
    # open for future files
  ] ++ lib.optional(builtins.pathExists rice_path) rice_path;

  home = {
    username = user;
    homeDirectory = "/home/${user}";

    stateVersion = stateVersion;

    packages = with pkgs; [
      kitty

      brave
      spotify
      obsidian

      vscode
      neovim
      git
      rustup
    ];
  };

  programs = {
    git = {
      enable =  true;
      userEmail = "dennis.tiderko@gmail.com";
      userName = "Gooxey";
    };
  };
}