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
  };
}
