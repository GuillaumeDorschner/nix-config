{ pkgs, ... }:

{
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.yubikey-agent.enable = true;

  # Lock session when yubi is unmount
  services.udev.extraRules = ''
    ACTION=="remove",\
     ENV{ID_BUS}=="usb",\
     ENV{ID_MODEL_ID}=="0407",\
     ENV{ID_VENDOR_ID}=="1050",\
     ENV{ID_VENDOR}=="Yubico",\
     RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';
}
