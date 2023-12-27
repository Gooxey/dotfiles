{ inputs, desktop_enviroment, lib, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../../modules/user
    ../../modules/nixos/common.nix

    ../../modules/nixos/desktop-enviroment/${desktop_enviroment}.nix
    inputs.home-manager.nixosModules.default
  ];
}
