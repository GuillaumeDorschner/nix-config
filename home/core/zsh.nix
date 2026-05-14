{ pkgs, user, ... }:

{
  home.packages = with pkgs; [ zsh ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "z"
        "sudo"
        "fzf"
        "kubectl"
      ];
    };

    shellAliases = {
      finder = "dolphin";
      ll = "ls -alh";
      gs = "git status";
      ocean = "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@$1 -i ~/.ssh/digital_ocean";
      server = "python3 -m http.server 8000";
    };

    initContent = ''
              export PERSONAL=/home/guillaume/personal
              export WORK=/home/guillaume/work/thales
              export HISTTIMEFORMAT="%d/%m/%y %T "
              export ANSIBLE_VAULT_PASSWORD_FILE=~/.password

              alias gitgraph='git log --graph --abbrev-commit --pretty=oneline'

              help() {
                echo "==================== ZSH SHORTCUTS ===================="
                echo ""
                echo "---- Shell aliases ----"
                echo "finder   -> dolphin"
                echo "ll       -> ls -alh"
                echo "gs       -> git status"
                echo "ocean    -> ssh to DigitalOcean (arg: host)"
                echo "server   -> python http server (port 8000 by default)"
                echo "gitgraph -> git log graph view"
                echo ""
                echo "---- Custom functions ----"
                echo "setup        -> edit nixos config + rebuild"
                echo "mcd <dir>    -> mkdir + cd"
                echo "start        -> open tmux session in JERNAS"
                echo "vm <image>   -> docker run interactive"
                echo "sf           -> fuzzy search + open in vim"
                echo "sk           -> kill process via fzf"
                echo "sg           -> git checkout branch via fzf"
                echo "sgp          -> git log picker (fzf + show)"
                echo ""
                echo "---- Notes ----"
                echo "Ctrl+T : fzf file picker (from plugin)"
                echo "Ctrl+R  : fzf command in the bash history"
                echo "Alt+C  : edit command line (if enabled)"
                echo "======================================================="
              }

              setup() {
                sudo vim /etc/nixos
                sudo nixos-rebuild switch
                exec zsh -l
              }

              mcd() {
                mkdir -p "$1" && cd "$1"
              }

              ensure_docker_running() {
                if ! systemctl is-active --quiet docker; then
                  echo "Starting Docker..."
                  sudo systemctl start docker
                fi
              }

              start() {
                cd $JERNAS
                bash tmux.sh
              }

              sf() {
                rg --line-number --no-heading --color=always "" |
      fzf --ansi --delimiter : --nth 3.. --preview 'bat --style=numbers --color=always {1} --line-range {2}:+' \
      --bind 'enter:execute(vim {1} +{2})'
              }

              sk() {
                ps -ef | fzf | awk '{print $2}' | xargs kill
              }

              sg() {
                git branch --all | fzf | sed 's/.* //; s#remotes/[^/]*/##' | xargs git checkout
              }

              sgp() {
                git log --oneline | fzf --preview 'git show {1}'
              }

              vm() {
                ensure_docker_running
                docker run --rm -it "$1"
              }
    '';
  };
}
