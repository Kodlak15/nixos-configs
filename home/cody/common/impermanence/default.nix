{inputs, ...}: {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  home.persistence."/persist/home/cody" = {
    directories = [
      "Documents"
      "Downloads"
      "Music"
      "Videos"
      "Pictures"
      ".ssh"
      ".gnupg"
      ".local/share/keyrings"
      ".local/share/direnv"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [];
    allowOther = true;
  };
}
