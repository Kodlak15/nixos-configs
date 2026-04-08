{pkgs, ...}: {
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.opencode.enable
  programs.opencode = {
    enable = true;
    package = pkgs.opencode;
    tui.theme = "ayu";
    settings = {
      # tui.theme = "ayu";
      permission = {
        edit = "ask";
        bash = "ask";
      };
      model = "moonshotai/kimi-k2.5";
    };
  };
}
