{ pkgs, user, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      serverAliveCountMax = 20;
      serverAliveInterval = 20;
      addKeysToAgent = "yes";
      controlMaster = "auto";
      controlPath = "~/.ssh/control-%C";
      controlPersist = "30m";
    };

    matchBlocks."github.com" = {
      user = "git";
      identityFile = "/home/guillaume/.ssh/gdorschner_yubikey"; # TODO: change to a general sops and use # config.sops.secrets."gdorschner_yubikey/private".path
    };
  };
}
