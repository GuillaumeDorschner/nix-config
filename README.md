# Nixos config

Here is my personal nix config, in there i use the following feature:

- sops
- home-manager (dotfiles config)
- plasma-manager
- flake-part
- import-tree
- nix-darwin (futur)
- secret github for secret things

### Tree

```bash
.
├── config
│   ├── asserts
│   │   ├── profile_picture.png
│   │   └── wallpaper.jpeg
│   ├── athena-nixos.qcow2
│   ├── darwin
│   │   ├── core.nix
│   │   └── homebrew.nix
│   ├── flake.lock
│   ├── flake.nix
│   ├── guillaume-nixos.qcow2
│   ├── home
│   │   ├── core
│   │   │   ├── default.nix
│   │   │   ├── git.nix
│   │   │   ├── ssh.nix
│   │   │   ├── tmux.nix
│   │   │   ├── vim.nix
│   │   │   └── zsh.nix
│   │   ├── optional
│   │   │   ├── brave.nix
│   │   │   ├── plasma.nix
│   │   │   └── vscode.nix
│   │   └── users
│   │       └── guillaume
│   │           └── default.nix
│   ├── hosts
│   │   ├── ares
│   │   │   └── default.nix
│   │   ├── athena
│   │   │   ├── default.nix
│   │   │   └── hardware-configuration.nix
│   │   └── plutus
│   │       └── default.nix
│   ├── justfile
│   ├── nixos
│   │   ├── core
│   │   │   ├── audio.nix
│   │   │   ├── boot.nix
│   │   │   ├── default.nix
│   │   │   ├── locale.nix
│   │   │   ├── networking.nix
│   │   │   ├── nix.nix
│   │   │   ├── packages.nix
│   │   │   ├── security.nix
│   │   │   ├── sops.nix
│   │   │   ├── virtualisation.nix
│   │   │   └── yubikey.nix
│   │   ├── optional
│   │   │   ├── gaming.nix
│   │   │   └── plasma.nix
│   │   └── users
│   │       └── guillaume
│   │           └── default.nix
│   ├── README.md
│   └── scripts
│       ├── bootstrap.sh
│       └── deploy.sh
```

## Yubikey

Using the key on another PC
The other machine needs OpenSSH 8.2+ and libfido2 installed. Then plug in the YubiKey and run:

```bash
ssh-keygen -K
```

in the directory where you want to store the key files (typically ~/.ssh/). This pulls the key handle from the YubiKey and writes two files, e.g. id*ed25519_sk_rk*<name> and id*ed25519_sk_rk*<name>.pub. The "private" file isn't a real private key — it's just a handle that's useless without the physical YubiKey

### Sudo

pour le cote sudo yubikey permet d'utilser le u2f

```
pamu2fcfg -opam://yubi -ipam://yubi > /home/<your_user>/.config/Yubico/u2f_keys
```

```nix
pam = {
    sshAgentAuth.enable = true;
    u2f = {
    enable = true;
    settings = {
        cue = true;
        authFile = "/home/guillaume/.config/Yubico/u2f_keys";
        origin = "pam://yubi"; # permet identifer la yubi
        appid = "pam://yubi";
    };
    };
    services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
    };
};
```

### LUKS

# TODO: make luks on pc and doc
