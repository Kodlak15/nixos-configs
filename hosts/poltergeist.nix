{
  imports = [
    ./local/security/poltergeist
    ./local/security/security.nix
  ];

  networking.hostName = "poltergeist";

  # Do not change this value
  system.stateVersion = "23.11";
}
