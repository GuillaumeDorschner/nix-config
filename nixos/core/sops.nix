{
  inputs,
  user,
  ...
}:
let
  secretspath = builtins.toString inputs.mysecrets;
in
{
  sops = {
    # TODO: create symlink for publickey in the authroiwed keys on user and root
    defaultSopsFile = "${secretspath}/secrets.yaml";
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/keys.txt";

    secrets = {
      "users/guillaume/password" = {
        neededForUsers = true;
      };
      "ssh_keys/gdorschner_yubikey/public" = {
        path = "/home/${user}/.ssh/gdorschner_yubikey.pub";
        owner = "${user}";
        mode = "0600";
      };
      "ssh_keys/gdorschner_yubikey/private" = {
        path = "/home/${user}/.ssh/gdorschner_yubikey";
        owner = "${user}";
        mode = "0600";
      };
      "ssh_keys/backup/public" = {
        path = "/home/${user}/.ssh/backup.pub";
        owner = "${user}";
        mode = "0600";
      };
      "ssh_keys/backup/private" = {
        path = "/home/${user}/.ssh/backup";
        owner = "${user}";
        mode = "0600";
      };
      "ssh_keys/github/public" = {
        # TODO: remove this in the futur
        path = "/home/${user}/.ssh/github.pub";
        owner = "${user}";
        mode = "0600";
      };
      "ssh_keys/github/private" = {
        # TODO: remove this in the futur
        path = "/home/${user}/.ssh/github";
        owner = "${user}";
        mode = "0600";
      };
      "u2f_mapping" = {
        path = "/home/${user}/.config/Yubico/u2f_keys";
        owner = "${user}";
        mode = "0600";
      };
    };
  };
}
