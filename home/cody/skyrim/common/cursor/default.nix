{pkgs, ...}: {
  home.packages = [pkgs.code-cursor];

  # Unable to configure cursor directly for now
  # Can configure vscode declaratively and load configuration into cursor
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      mvllow.rose-pine
    ];
    keybindings = [];
    userSettings = {
      "[templ]" = {
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "a-h.templ";
      };
      "editor.guides.indentation" = false;
      "editor.guides.highlightActiveIndentation" = false;
      "tailwindCSS.includeLanguages" = {
        "templ" = "html";
      };
      "emmet.includeLanguages" = {
        "templ" = "html";
      };
      "files.associations" = {
        "*.templ" = "templ";
      };
      "vim.leader" = "<space>";
      "vim.useSystemClipboard" = true;
      "vim.smartRelativeLine" = true;
      "vim.handleKeys" = {
        "<C-d>" = true;
        "<C-f>" = true;
      };
      "workbench.colorTheme" = "Rosé Pine";
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
}
