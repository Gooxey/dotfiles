{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }@inputs:
    let
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      username = "dennis";
      stateVersion = "24.05";

      modules = [
        ./config

        # install home manager
        (
          { pkgs, ... }:
          {
            environment.systemPackages = [
              pkgs.home-manager
            ];
          }
        )

        ###########################
        #     desktop environment #
        ###########################

        # if you have not yet built cosmic, run nixos-rebuild test with only
        # the cache added
        # ./desktop-environment/cosmic

        # do not forget to enable the hyprland home-manager config
        # ./desktop-environment/hyprland

        # ./desktop-environment/gnome

        ./desktop-environment/gnome-cosmic
      ];
    in
    {
      formatter."x86_64-linux" = nixpkgs.legacyPackages."x86_64-linux".nixfmt-rfc-style;

      nixosConfigurations = {
        kraken = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit username stateVersion inputs;
          };
          modules = [
            ./host/kraken
          ] ++ modules;
        };

        squid = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit username stateVersion inputs;
          };
          modules = [
            ./host/squid
          ] ++ modules;
        };
      };

      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit username stateVersion inputs;
        };
        modules = [
          nixvim.homeManagerModules.default

          ./home-manager

          ##########################
          # change files if needed #
          ##########################

          # hyprland rice
          # ./desktop-environment/hyprland/home-manager

          # gnome rice
          ./desktop-environment/gnome/home-manager
        ];
      };
    };
}
