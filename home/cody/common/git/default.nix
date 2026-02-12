{pkgs, ...}: {
  # CLI tools
  home.packages = with pkgs; [
    gh
    glab
    codeberg-cli
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kodlak15";
        email = "stanlcod15@protonmail.com";
      };
    };
  };
}
