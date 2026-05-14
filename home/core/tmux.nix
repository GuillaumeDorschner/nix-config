{ pkgs, user, ... }:

{
  home.packages = with pkgs; [ tmux ];

  programs = {
    tmux = {
      enable = true;
      package = pkgs.tmux;

      extraConfig = ''
        set -g mouse on
        set -g history-limit 20000

        set -g default-shell ${pkgs.zsh}/bin/zsh
        set -g default-command ${pkgs.zsh}/bin/zsh

        set -g base-index 1
        set -g renumber-windows on
        setw -g mode-keys vi

        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"
        bind c new-window -c "#{pane_current_path}"

        bind C-s command-prompt -p "session name:" "new-session -s '%%'"
        bind C-k confirm-before "kill-session"

        # easy pane navigation (vim-style)
        bind -n C-h select-pane -L
        bind -n C-j select-pane -D
        bind -n C-k select-pane -U
        bind -n C-l select-pane -R

        # Vim window switching
        bind -n M-h previous-window     # Alt-h → previous window
        bind -n M-l next-window         # Alt-l → next window

        bind -n M-j switch-client -p    # Alt-j → previous session
        bind -n M-k switch-client -n    # Alt-k → next session

        bind y setw synchronize-panes
      '';
    };
  };
}
