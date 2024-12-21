{
  programs.pywal.enable = true;
  # NOTE: this does not work as files must be mutable
  # home.file = {
  #   ".cache/wal/colors-tty.sh" = {
  #     source = ./colors-tty.sh;
  #   };
  #   ".cache/wal/colors-zsh.zsh" = {
  #     source = ./colors-zsh.zsh;
  #   };
  #   ".cache/wal/sequences" = {
  #     source = ./sequences;
  #   };
  # };
  xdg.configFile = {
    "wal/templates/colors-tmux.conf".text = builtins.readFile ./templates/colors-tmux.conf;
    "wal/templates/colors-zsh.zsh".text = builtins.readFile ./templates/colors-zsh.zsh;
    "wal/templates/hyprland-colors.conf".text = builtins.readFile ./templates/hyprland-colors.conf;
    "wal/templates/nix-snowflake.svg".text = builtins.readFile ./templates/nix-snowflake.svg;
  };
}
