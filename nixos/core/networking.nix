{
  host,
  ...
}:

{
  services.resolved.enable = true;

  networking = {
    networkmanager.dns = "systemd-resolved";
    networkmanager.enable = true;
    hostName = "${host}-nixos";
  };
}
