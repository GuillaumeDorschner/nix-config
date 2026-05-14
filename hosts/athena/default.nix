{ inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../nixos/core
    ../../nixos/optional/plasma.nix
    ../../nixos/users/guillaume
    inputs.mysecrets.nixosModules.default
  ];

  services.xserver.videoDrivers = [
    "modesetting"
    "amdgpu"
  ];
  hardware.enableAllFirmware = true;
  services.libinput.enable = true;
  services.blueman.enable = false; # for the Blueman KDE/GNOME tray app

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
    users.guillaume = import ../../home/users/guillaume;
  };

  system.stateVersion = "25.11";
}
