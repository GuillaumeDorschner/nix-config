{ config, pkgs, ... }:

{
  users.users = {
    root.openssh.authorizedKeys.keyFiles = [
      ./keys/gdorschner_yubikey.pub
      ./keys/work_gdorschner_yubikey.pub
    ];

    guillaume = {
      isNormalUser = true;
      description = "guillaume";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      packages = with pkgs; [
        kdePackages.kate
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keyFiles = [
        ./keys/gdorschner_yubikey.pub
      ];
      hashedPasswordFile = config.sops.secrets."users/guillaume/password".path;
    };
  };
}
