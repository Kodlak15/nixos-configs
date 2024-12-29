{...}: {
  programs.tmux = {
    enable = true;
    extraConfig = ''
      # Use terminal default colors
      set-default colorset-option -ga terminal-overrides ",xterm-256color:Tc"
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"
      # Disable tmux's color changing
      set -g window-style 'fg=default,bg=default'
      set -g window-active-style 'fg=default,bg=default'
    '';
  };
}
