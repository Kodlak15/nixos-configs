{
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      pane_frames = false;
      tab_bar = false;
      default_layout = "compact";
      theme = "ayu_dark";
      keybinds = {
        unbind = [
          "Ctrl p"
          "Ctrl n"
        ];
      };
      default_shell = "zsh";
      ui = {
        pane_frames = {
          hide_session_name = true;
        };
      };
      show_startup_tips = false;
      show_release_notes = false;
    };
  };
}
