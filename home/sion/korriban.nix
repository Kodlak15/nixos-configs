{
  imports = [
    ./korriban
  ];

  home = {
    username = "sion";
    homeDirectory = "/home/sion";

    stateVersion = "24.05";
  };

  # Let home-manager install and manager itself
  # programs.home-manager.enable = true;
}
