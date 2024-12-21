{inputs, ...}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age = {
      keyFile = "/home/cody/.config/sops/age/keys.txt";
    };
    validateSopsFiles = false;
    secrets = {
      "private_keys/sops" = {
        path = "/home/cody/.config/sops/age/keys.txt";
        sopsFile = ./secrets.yaml;
      };
    };
  };
}
