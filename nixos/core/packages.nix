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
    meld
    signal-desktop
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
    nix-search-cli
    # Linux
    git-lfs
    nixd
    nixfmt
    just
    devenv
    # Linux
    git-lfs
    python313Packages.git-filter-repo
    curl
    mlocate
    lsof
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
    yq
    time
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
    kubectl
    kubernetes-helm
    k9s
    kubectl-explore
    minikube
    kind
    ansible
    vagrant
    opentofu
    terraform
    oras
    openldap
    shelldap
    pssh
    mkcert
  ];
}
