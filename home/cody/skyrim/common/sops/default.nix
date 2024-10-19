{inputs, ...}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age = {
      keyFile = "/home/cody/.config/sops/age/keys.txt";
    };
    defaultSopsFile = ./secrets.yaml;
    validateSopsFiles = false;
    secrets = {
      "anthropic_api_key" = {
        path = "%r/anthropic_api_key";
      };
    };
  };
}
