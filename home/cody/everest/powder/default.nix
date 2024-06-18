{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.powder.packages.${pkgs.system}.default
  ];

  xdg.configFile = {
    "powder/config.yaml".text = ''
      everest:
        default: 1
        flake: "/home/cody/nix/flakes/nixos"
        nixos:
          name: "personal/everest"
        hm:
          name: "personal/everest"
          user: "cody"
        jobs: 4
    '';
  };
}
