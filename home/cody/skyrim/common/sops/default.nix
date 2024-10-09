{inputs, ...}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age = {
      keyFile = "/home/cody/.config/sops/age/keys.txt";
    };
    # defaultSopsFile = ../secrets.yaml;
    validateSopsFiles = false;
    secrets = {
      "anthropic_api_key" = {
        # path = 
      };
      "private_keys/sops" = {
        path = "/home/cody/.config/sops/age/keys.txt";
        sopsFile = 
      };
      "private_keys/pwncollege" = {
        path = "/home/cody/.ssh/pwn";
      };
      "private_keys/digitalOcean" = {
        path = "/home/cody/.ssh/digitalOcean";
      };
      "private_keys/github" = {
        path = "/home/cody/.ssh/gh";
      };
      "private_keys/cyrodil" = {
        path = "/home/cody/.ssh/cyrodil";
      };
    };
  };
}
