{
  imports = [
    ./local/security/casper
    ./local/security/security.nix
  ];

  networking.hostName = "casper";

  # Do not change this value
  system.stateVersion = "23.11";
}
