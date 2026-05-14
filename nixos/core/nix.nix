{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  system.autoUpgrade.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    EDITOR = "vim";
  };

  programs.zsh.enable = true;

}
