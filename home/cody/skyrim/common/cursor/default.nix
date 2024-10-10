{pkgs, ...}: {
  home.packages = [pkgs.code-cursor];

  # Unable to configure cursor directly for now
  # Can configure vscode declaratively and load configuration into cursor
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # Color schemes
      mvllow.rose-pine
      # Editor modifications
      vscodevim.vim
    ];
    keybindings = [];
    userSettings = {
      "editor.formatOnSave" = true;
      "[templ]" = {
        "editor.defaultFormatter" = "a-h.templ";
      };
      "tailwindCSS.includeLanguages" = {
        "templ" = "html";
      };
      "emmet.includeLanguages" = {
        "templ" = "html";
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
      ];
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          before = ["K"];
          commands = ["editor.action.showDefinitionPreviewHover"];
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
        # 1. Search for text in workspace
        {
          before = ["<leader>" "f" "g"];
          commands = ["workbench.action.findInFiles"];
        }
        # 2. Search for file in workspace
        {
          before = ["<leader>" "g"];
          commands = ["workbench.action.quickOpen"];
        }
        # 3. Toggle primary sidebar
        {
          before = ["<leader>" "e"];
          commands = ["workbench.action.toggleSidebarVisibility"];
        }
      ];
    };
  };
}
