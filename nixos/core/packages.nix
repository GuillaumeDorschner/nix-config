{ pkgs, ... }:

{
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    # Software
    libreoffice-qt6-fresh
    wireshark
    vlc
    cider-2
    yt-dlp
    drawio
    gimp
    # YubiKey
    yubioath-flutter # Yubico Authenticator
    yubikey-manager # CLI
    pam_u2f
    ssh-to-age
    age
    sops
    # Linux Desktop
    bluez
    kdePackages.partitionmanager
    # Nixos
    nixd
    nixfmt
    just
    devenv
    # Linux
    git-lfs
    python313Packages.git-filter-repo
    curl
    mlocate
    wget
    dig
    htop
    wl-clipboard
    btop
    openssl
    tree
    usbutils
    util-linux
    lazygit
    gnumake
    fd
    jq
    unixtools.netstat
    tcpdump
    ripgrep
    pciutils
    gnupg
    nmap
    traceroute
    fzf
    # Language
    python3
    pnpm
    nodejs_24
    # DevOps
    ansible
    kubectl
    kubectl-explore
    minikube
    kind
    vagrant
    opentofu
    oras
    shelldap
  ];
}
