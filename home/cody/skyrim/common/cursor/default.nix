{pkgs, ...}: {
  home.packages = [pkgs.cursor];

  # NOTE:
  # No way to configure cursor with nix as of now
  # Can load vscode config within cursor instead
  # In order to do so vscode.enable = true must be set
  programs.vscode = {
    enable = true;
    # package = pkgs.cursor;
    extensions = with pkgs.vscode-extensions; [
      # Color schemes
      mvllow.rose-pine
      # Editor modifications
      vscodevim.vim
    ];
    keybindings = [];
    userSettings = {
      "vim.leader" = "<space>";
      "vim.useSystemClipboard" = true;
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
      ];
    };
  };
}
