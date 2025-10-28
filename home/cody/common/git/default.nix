{pkgs, ...}: {
  # CLI tools
  home.packages = with pkgs; [
    gh
    glab
    codeberg-cli
  ];

  programs.git = {
    enable = true;
    userName = "Kodlak15";
    userEmail = "stanlcod15@protonmail.com";
    # NOTE: this is supposed to be the correct way of declaring these settings,
    # but the values were not being set properly and git stopped working.
    # settings = {
    #   user = {
    #     userName = "Kodlak15";
    #     userEmail = "stanlcod15@protonmail.com";
    #   };
    # };
  };
}
