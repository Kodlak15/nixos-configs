{pkgs, ...}: let
  _ = pkgs.buildNpmPackage {
    name = "cascade-botanicals-svelte";
    src = ./.;
    npmDepsHash = "sha256-A652NvAZsVn9w+yO5ljxBEPGZV04rGIAYgyj29/u8Yo=";

    installPhase = ''
      npm run build
      mkdir -p $out/bin
      mv build $out/bin
    '';
  };
in
  pkgs.writeShellApplication {
    name = "cascade-botanicals";
    text = ''
      node build
    '';
  }
