{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "23.11"; # Did you read the comment?

    mkSystem = hostname: desktop_enviroment: rice:
      nixpkgs.lib.nixosSystem {
        system =  "x86_64-linux";
        specialArgs = { inherit inputs stateVersion desktop_enviroment rice; };
        modules = [
          { networking.hostName = hostname; }
          ./hosts/${hostname}/configuration.nix
          home-manager.nixosModules.default
        ];
      };
  in {
    nixosConfigurations = {
      vm-gnome-cyberpunk = mkSystem "vm" "gnome" "cyberpunk";
    };
  };
}