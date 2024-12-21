{inputs, ...}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../common
    ./hyprland
    ./eww
    # ./sops
  ];

  home = {
    username = "cody";
    homeDirectory = "/home/cody";

    stateVersion = "23.05";
  };

  # Let home-manager install and manager itself
  programs.home-manager.enable = true;
}
