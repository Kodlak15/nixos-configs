{
  programs.tmux = {
    # enable = true;
    extraConfig = ''
      source-file $HOME/.cache/wal/colors-tmux.conf
    '';
  };
}
