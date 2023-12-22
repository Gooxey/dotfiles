{ inputs, stateVersion, pkgs, desktop_enviroment, rice, ... }:
let
  user = "dennis";
in {
  users.users.${user} = {
    isNormalUser = true;
    description = "${user}";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs user stateVersion desktop_enviroment rice;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "${user}" = import ./home.nix;
    };
  };
}