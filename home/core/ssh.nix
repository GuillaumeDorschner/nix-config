{ osConfig, ... }:

{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        ServerAliveCountMax = 20;
        ServerAliveInterval = 20;
        AddKeysToAgent = "yes";
        ControlMaster = "auto";
        ControlPath = "~/.ssh/control-%C";
        ControlPersist = "30m";
      };

      "github.com" = {
        User = "git";
        IdentityFile = osConfig.sops.secrets."ssh_keys/gdorschner_yubikey/private".path;
      };
    };
  };
}
