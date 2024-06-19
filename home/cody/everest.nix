{
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
    outputs.homeManagerModules.powder
    ./global
    ./everest
  ];

  home = {
    username = "cody";
    homeDirectory = "/home/cody";

    stateVersion = "23.05";
  };

  # Let home-manager install and manager itself
  programs.home-manager.enable = true;
}
