{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12.0;
        # draw_bold_text_with_bright_colors = true;
      };
      window = {
        padding = {
          x = 5;
          y = 5;
        };
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
}
