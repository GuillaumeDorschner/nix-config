{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/core
    ../../nixos/optional/gaming.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
    users.guillaume = import ../../home/modules;
  };

  system.stateVersion = "25.11";
}
