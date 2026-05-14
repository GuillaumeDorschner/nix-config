{ pkgs, user, ... }:

{
  users.mutableUsers = false;

  security = {
    rtkit.enable = true;

    pam = {
      sshAgentAuth.enable = true;
      u2f = {
        enable = true;
        settings = {
          cue = true;
          authFile = "/home/guillaume/.config/Yubico/u2f_keys";
          origin = "pam://yubi";
          appid = "pam://yubi";
        };
      };
      services = {
        # login.u2fAuth = true; # remove for security reasons
        sudo.u2fAuth = true;
      };
    };
  };
}
