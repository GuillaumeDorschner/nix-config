# TODO
{ inputs, ... }:
{
  imports = [
    # ./hardware-configuration.nix
    ../../nixos/core
    ../../darwin
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.guillaume = import ../../home/common; # add the dawrin modules
  };

  system.stateVersion = "25.11"; # ??? linux version so remove for dawrin ?
}
