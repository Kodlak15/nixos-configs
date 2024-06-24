{
  imports = [
    ./testvm
  ];

  home = {
    username = "user";
    homeDirectory = "/home/user";

    stateVersion = "23.05";
  };

  # Let home-manager install and manager itself
  programs.home-manager.enable = true;
}
