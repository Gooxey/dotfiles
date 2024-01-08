{ config, lib, ... }: with lib;
let
  cfg = config.userdata;
in {
  options.userdata = {
    # user set
    user = mkOption { type = types.str; };
    stateVersion = mkOption {
      type = types.str;
      # https://search.nixos.org/options?channel=23.11&show=system.stateVersion&from=0&size=50&sort=relevance&type=packages&query=stateVersion
      default = "23.11";
    };

    # flake set
    host = mkOption { type = types.str; };
    desktop_environment = mkOption { type = types.str; };
    rice = mkOption { type = types.str; };
  };
}