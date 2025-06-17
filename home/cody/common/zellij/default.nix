{
  programs.zellij = {
    enable = true;
    enableZshIntegration = false;
    settings = {
      pane_frames = false;
      tab_bar = false;
      default_layout = "compact";
      theme = "ayu_mirage";
      keybinds = {
        unbind = [
          "Ctrl p" # interferes with nvim binding
          "Ctrl n" # interferes with nvim binding
          "Ctrl o" # interferes with opencode binding
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
      themes = {
        ayu_dark = {
          text_unselected = {
            base = "#cccac2";
            background = "#131721";
            emphasis_0 = "#ff8f40";
            emphasis_1 = "#73b8ff";
            emphasis_2 = "#aad94c";
            emphasis_3 = "#d2a6ff";
          };
          text_selected = {
            base = "#cccac2";
            background = "#475266";
            emphasis_0 = "#ff8f40";
            emphasis_1 = "#73b8ff";
            emphasis_2 = "#aad94c";
            emphasis_3 = "#d2a6ff";
          };
          ribbon_selected = {
            base = "#131721";
            background = "#aad94c";
            emphasis_0 = "#f07178";
            emphasis_1 = "#ff8f40";
            emphasis_2 = "#d2a6ff";
            emphasis_3 = "#59c2ff";
          };
          ribbon_unselected = {
            base = "#131721";
            background = "#bfbdb6";
            emphasis_0 = "#f07178";
            emphasis_1 = "#cccac2";
            emphasis_2 = "#59c2ff";
            emphasis_3 = "#d2a6ff";
          };
          table_title = {
            base = "#aad94c";
            background = "#000000";
            emphasis_0 = "#ff8f40";
            emphasis_1 = "#73b8ff";
            emphasis_2 = "#aad94c";
            emphasis_3 = "#d2a6ff";
          };
          table_cell_selected = {
            base = "#cccac2";
            background = "#475266";
            emphasis_0 = "#ff8f40";
            emphasis_1 = "#73b8ff";
            emphasis_2 = "#aad94c";
            emphasis_3 = "#d2a6ff";
          };
          table_cell_unselected = {
            base = "#cccac2";
            background = "#131721";
            emphasis_0 = "#ff8f40";
            emphasis_1 = "#73b8ff";
            emphasis_2 = "#aad94c";
            emphasis_3 = "#d2a6ff";
          };
          list_selected = {
            base = "#cccac2";
            background = "#475266";
            emphasis_0 = "#ff8f40";
            emphasis_1 = "#73b8ff";
            emphasis_2 = "#aad94c";
            emphasis_3 = "#d2a6ff";
          };
          list_unselected = {
            base = "#cccac2";
            background = "#131721";
            emphasis_0 = "#ff8f40";
            emphasis_1 = "#73b8ff";
            emphasis_2 = "#aad94c";
            emphasis_3 = "#d2a6ff";
          };
          frame_selected = {
            base = "#aad94c";
            background = "#000000";
            emphasis_0 = "#ff8f40";
            emphasis_1 = "#73b8ff";
            emphasis_2 = "#d2a6ff";
            emphasis_3 = "#000000";
          };
          frame_highlight = {
            base = "#ff8f40";
            background = "#000000";
            emphasis_0 = "#d2a6ff";
            emphasis_1 = "#ff8f40";
            emphasis_2 = "#ff8f40";
            emphasis_3 = "#ff8f40";
          };
          exit_code_success = {
            base = "#aad94c";
            background = "#000000";
            emphasis_0 = "#73b8ff";
            emphasis_1 = "#131721";
            emphasis_2 = "#d2a6ff";
            emphasis_3 = "#59c2ff";
          };
          exit_code_error = {
            base = "#f07178";
            background = "#000000";
            emphasis_0 = "#e6b450";
            emphasis_1 = "#000000";
            emphasis_2 = "#000000";
            emphasis_3 = "#000000";
          };
          multiplayer_user_colors = {
            player_1 = "#d2a6ff";
            player_2 = "#59c2ff";
            player_3 = "#000000";
            player_4 = "#e6b450";
            player_5 = "#73b8ff";
            player_6 = "#000000";
            player_7 = "#f07178";
            player_8 = "#000000";
            player_9 = "#000000";
            player_10 = "#000000";
          };
        };
        ayu_mirage = {
          text_unselected = {
            base = "#c7c7c7";
            background = "#1a1f29";
            emphasis_0 = "#ffad66";
            emphasis_1 = "#444b55";
            emphasis_2 = "#d5ff80";
            emphasis_3 = "#dfbfff";
          };
          text_selected = {
            base = "#c7c7c7";
            background = "#409fff";
            emphasis_0 = "#ffad66";
            emphasis_1 = "#444b55";
            emphasis_2 = "#d5ff80";
            emphasis_3 = "#dfbfff";
          };
          ribbon_selected = {
            base = "#1a1f29";
            background = "#d5ff80";
            emphasis_0 = "#f28779";
            emphasis_1 = "#ffad66";
            emphasis_2 = "#dfbfff";
            emphasis_3 = "#73d0ff";
          };
          ribbon_unselected = {
            base = "#1a1f29";
            background = "#cccac2";
            emphasis_0 = "#f28779";
            emphasis_1 = "#c7c7c7";
            emphasis_2 = "#73d0ff";
            emphasis_3 = "#dfbfff";
          };
          table_title = {
            base = "#d5ff80";
            background = "#000000";
            emphasis_0 = "#ffad66";
            emphasis_1 = "#444b55";
            emphasis_2 = "#d5ff80";
            emphasis_3 = "#dfbfff";
          };
          table_cell_selected = {
            base = "#c7c7c7";
            background = "#409fff";
            emphasis_0 = "#ffad66";
            emphasis_1 = "#444b55";
            emphasis_2 = "#d5ff80";
            emphasis_3 = "#dfbfff";
          };
          table_cell_unselected = {
            base = "#c7c7c7";
            background = "#1a1f29";
            emphasis_0 = "#ffad66";
            emphasis_1 = "#444b55";
            emphasis_2 = "#d5ff80";
            emphasis_3 = "#dfbfff";
          };
          list_selected = {
            base = "#c7c7c7";
            background = "#409fff";
            emphasis_0 = "#ffad66";
            emphasis_1 = "#444b55";
            emphasis_2 = "#d5ff80";
            emphasis_3 = "#dfbfff";
          };
          list_unselected = {
            base = "#c7c7c7";
            background = "#1a1f29";
            emphasis_0 = "#ffad66";
            emphasis_1 = "#444b55";
            emphasis_2 = "#d5ff80";
            emphasis_3 = "#dfbfff";
          };
          frame_selected = {
            base = "#d5ff80";
            background = "#000000";
            emphasis_0 = "#ffad66";
            emphasis_1 = "#444b55";
            emphasis_2 = "#dfbfff";
            emphasis_3 = "#000000";
          };
          frame_highlight = {
            base = "#ffad66";
            background = "#000000";
            emphasis_0 = "#dfbfff";
            emphasis_1 = "#ffad66";
            emphasis_2 = "#ffad66";
            emphasis_3 = "#ffad66";
          };
          exit_code_success = {
            base = "#d5ff80";
            background = "#000000";
            emphasis_0 = "#444b55";
            emphasis_1 = "#1a1f29";
            emphasis_2 = "#dfbfff";
            emphasis_3 = "#73d0ff";
          };
          exit_code_error = {
            base = "#f28779";
            background = "#000000";
            emphasis_0 = "#ffcc77";
            emphasis_1 = "#000000";
            emphasis_2 = "#000000";
            emphasis_3 = "#000000";
          };
          multiplayer_user_colors = {
            player_1 = "#dfbfff";
            player_2 = "#73d0ff";
            player_3 = "#000000";
            player_4 = "#ffcc77";
            player_5 = "#444b55";
            player_6 = "#000000";
            player_7 = "#f28779";
            player_8 = "#000000";
            player_9 = "#000000";
            player_10 = "#000000";
          };
        };
      };
    };
  };
}
