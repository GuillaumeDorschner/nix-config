{ inputs, ... }:

{
  system.stateVersion = "25.11";

  imports = [
    ./hardware-configuration.nix
    ../../nixos/core
    ../../nixos/optional/plasma.nix
    ../../nixos/users/guillaume
    inputs.mysecrets.nixosModules.default
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
    users.guillaume = import ../../home/users/guillaume;
  };

  hardware = {
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    xserver.videoDrivers = [
      "modesetting"
      "amdgpu"
    ];
    libinput.enable = true;
    blueman.enable = false; # for the Blueman KDE/GNOME tray app
  };
}
