# TODO apply gtk theme on all apps
# TODO 9 and 10 as preserved workspaces and show their icon there

{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    # https://search.nixos.org/options?channel=23.11&show=system.stateVersion&from=0&size=50&sort=relevance&type=packages&query=stateVersion
    stateVersion = "23.11";
    userdata = (import ./userdata.nix);
  in {
    nixosConfigurations.from-userdata = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs stateVersion userdata; };
      modules = [
        ./desktop-environment/${userdata.desktop_environment}/nixos
        ./host/${userdata.host}
        ./system

        # ./misc/userdata-options.nix
        home-manager.nixosModules.default {
          # more config at ./system
          home-manager.users."${userdata.user}" = import ./home-manager;
        }
      ];
    };
  };
}
