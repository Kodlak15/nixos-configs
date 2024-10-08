{pkgs, ...}: {
  home.packages = [pkgs.cursor];

  programs.vscode = {
    enable = false;
    # package = pkgs.cursor;
    extensions = with pkgs.vscode-extensions; [
      # Color schemes
      mvllow.rose-pine
      # Editor modifications
      vscodevim.vim
    ];
  };
}
