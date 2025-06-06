{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.code-cursor;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        teabyii.ayu
        golang.go
        geequlim.godot-tools
        ms-python.python
        bradlc.vscode-tailwindcss
        dbaeumer.vscode-eslint
        jnoortheen.nix-ide
        kamadorueda.alejandra
        timonwong.shellcheck
        elixir-lsp.vscode-elixir-ls
        phoenixframework.phoenix
      ];
      userSettings = {
        "editor.formatOnSave" = true;
        "[templ]" = {
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "a-h.templ";
        };
        "editor.guides.indentation" = false;
        "editor.guides.highlightActiveIndentation" = false;
        "tailwindCSS.includeLanguages" = {
          "templ" = "html";
          "phoenix-heex" = "html";
        };
        "emmet.includeLanguages" = {
          "templ" = "html";
          "phoenix-heex" = "html";
        };
        "files.associations" = {
          "*.templ" = "templ";
          "*.html.heex" = "html";
        };
        "vim.leader" = "<space>";
        "vim.useSystemClipboard" = true;
        "vim.smartRelativeLine" = true;
        "vim.handleKeys" = {
          "<C-d>" = true;
          "<C-f>" = true;
        };
        "workbench.colorTheme" = "Ayu Mirage";
        "vim.insertModeKeyBindings" = [
          {
            before = ["j" "k"];
            after = ["<Esc>"];
          }
          {
            before = ["k" "j"];
            after = ["<Esc>"];
          }
          {
            before = ["<C-n>"];
            commands = ["selectNextSuggestion"];
            when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && text";
          }
          {
            before = ["<C-p>"];
            commands = ["selectPrevSuggestion"];
            when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && text";
          }
        ];
        "vim.normalModeKeyBindingsNonRecursive" = [
          {
            before = ["K"];
            commands = ["editor.action.showDefinitionPreviewHover"];
          }
          {
            # Next LSP error
            before = ["g" "l"];
            commands = ["editor.action.marker.next"];
          }
          {
            # Previous LSP error
            before = ["g" "h"];
            commands = ["editor.action.marker.prev"];
          }
          {
            before = ["g" "i"];
            commands = ["editor.action.goToImplementation"];
          }
          {
            before = ["g" "r"];
            commands = ["editor.action.referenceSearch.trigger"];
          }
          {
            before = ["g" "t"];
            commands = ["editor.action.goToTypeDefinition"];
          }
          {
            before = ["<leader>" "b" "d"];
            commands = ["workbench.action.closeActiveEditor"];
          }
          {
            before = ["H"];
            commands = ["workbench.action.previousEditor"];
          }
          {
            before = ["L"];
            commands = ["workbench.action.nextEditor"];
          }
          {
            # Search for text in workspace
            before = ["<leader>" "f" "g"];
            commands = ["workbench.action.findInFiles"];
          }
          {
            # Search for file in workspace
            before = ["<leader>" "g"];
            commands = ["workbench.action.quickOpen"];
          }
          {
            # Remove default key for quickOpen
            before = ["<C-p>"];
            commands = ["-workbench.action.quickOpen"];
          }
          {
            # Toggle primary sidebar
            before = ["<leader>" "e"];
            commands = ["workbench.action.toggleSidebarVisibility"];
          }
          {
            before = ["<leader>" "k"];
            commands = ["editor.action.commentLine"];
          }
          {
            before = ["<leader>" "h"];
            commands = ["editor.action.commentBlock"];
          }
        ];
        "vim.visualModeKeyBindingsNonRecursive" = [
          {
            before = ["<leader>" "k"];
            commands = ["editor.action.commentLine"];
          }
          {
            before = ["<leader>" "h"];
            commands = ["editor.action.commentBlock"];
          }
        ];
      };
    };
  };
}
