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
      denali:
        default: 1
        flake: "/home/cody/nix/flakes/nixos"
        nixos:
          name: "personal/denali"
        hm:
          name: "personal/denali"
          user: "cody"
        jobs: 4
    '';
  };
}
