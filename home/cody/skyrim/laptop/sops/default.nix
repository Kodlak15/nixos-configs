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
      "anthropic_api_key" = {
        path = "%r/anthropic_api_key";
        sopsFile = ./secrets.yaml;
      };
      "private_keys/sops" = {
        path = "/home/cody/.config/sops/age/keys.txt";
        sopsFile = ./secrets.yaml;
      };
      "private_keys/pwncollege" = {
        path = "/home/cody/.ssh/pwn";
        sopsFile = ./secrets.yaml;
      };
      "private_keys/digitalOcean" = {
        path = "/home/cody/.ssh/digitalOcean";
        sopsFile = ./secrets.yaml;
      };
      "private_keys/github" = {
        path = "/home/cody/.ssh/gh";
        sopsFile = ./secrets.yaml;
      };
      "private_keys/cyrodil" = {
        path = "/home/cody/.ssh/cyrodil";
        sopsFile = ./secrets.yaml;
      };
      # Look into a better way to deal with this
      "ssh_config" = {
        path = "/home/cody/.ssh/config";
        sopsFile = ./secrets.yaml;
      };
    };
  };
}
