{ pkgs, ... }:

{
  home.packages = with pkgs; [ git ];

  programs = {
    git = {
      settings = {
        init.defaultBranch = "main";
        pull.rebase = false;
        push.autoSetupRemote = true;
        url."git@github.com:".insteadOf = "https://github.com/";
      };

      enable = true;
      ignores = [ ".DS_Store" ];
      lfs.enable = true;

      includes = [
        {
          path = ./.gitconfig-personal;
        }
        {
          condition = "gitdir:~/work/";
          path = ./.gitconfig-work;
        }
      ];
    };
  };
}
