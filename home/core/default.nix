{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./ssh.nix
    ./tmux.nix
    ./vim.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    home-manager
    coreutils
    starship
  ];
}
