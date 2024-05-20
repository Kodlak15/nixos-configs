{
  imports = [./colors.nix];

  programs.tmux = {
    enable = true;
    extraConfig = ''
      # source-file $HOME/.cache/wal/colors-tmux.conf

      # Match session numbers to number row
      set -g base-index 0
      # Set TERM, the default is "screen", "screen-256color" can be tried if "tmux-256color" doesn't work.
      # set -g default-terminal "tmux-256color"
      set -g default-terminal "screen-256color"
      # Enable mouse
      set -g mouse on
      # Disable drag action in normal mode if your pointer causes problems with
      unbind -n MouseDrag1Pane
      # Set the colors
      # set-option -g status-style fg="#ffffff",bg="#000000"
      # set-window-option -g window-status-current-style bg="#000000"
      # set-option -g pane-border-style fg="#000000"
      # set-option -g pane-active-border-style fg="#000000"
    '';
  };
}
