{
  config,
  pkgs,
  host,
  user,
  ...
}:

{
  networking = {
    networkmanager.enable = true;
    hostName = "${host}-nixos";
  };
}
