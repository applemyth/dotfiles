{ lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    prefix = "`";
    terminal = "tmux-256color";

    extraConfig = ''
      unbind r
      bind r source-file ~/.tmux.conf

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      set -g status-position bottom

      set -g status-bg color233
      set -g status-fg color250
      set -g window-status-current-style bg=color208,fg=color233
      set -g window-status-style bg=color237,fg=color241
      set -g pane-border-style fg=color241
      set -g pane-active-border-style fg=color208
      set -g message-style bg=color233,fg=color208
      set -g message-command-style bg=color233,fg=color208

    '' + lib.optionalString pkgs.stdenv.isDarwin ''
      bind-key -T copy-mode-vi Y send -X copy-pipe-and-cancel "pbcopy"
      bind-key -T copy-mode Y send -X copy-pipe-and-cancel "pbcopy"
    '';
  };
}
