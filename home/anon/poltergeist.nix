{
  imports = [
    ./local/poltergeist
    ./global
  ];

  home = {
    username = "anon";
    homeDirectory = "/home/anon";

    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
