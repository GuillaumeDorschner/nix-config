{ pkgs, ... }:

{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    blacklistedKernelModules = [ "mt76x2u" ]; # Disable xbox dongle avoid laggy wifi
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # disable hibernation make nixos freeze if encrypted
  services.logind.settings.Login = {
    HandleHibernateKey = "ignore";
    HandleHibernateKeyLongPress = "ignore";
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };
}
