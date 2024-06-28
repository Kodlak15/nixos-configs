{
  pkgs,
  lib,
}: let
  go-blueprint = pkgs.buildGoModule rec {
    pname = "go-blueprint";
    version = "0.5.14";

    src = pkgs.fetchFromGitHub {
      owner = "Melkeydev";
      repo = "go-blueprint";
      rev = "v${version}";
      hash = "sha256-vQ7LXC70MpqdHxR4JpM5iRQ4mTO0MVtZF94G/f8sR6A=";
    };

    vendorHash = "sha256-WBzToupC1/O70OYHbKk7S73OEe7XRLAAbY5NoLL7xvw=";

    meta = with lib; {
      description = "The ultimate golang blueprint library";
      homepage = "https://github.com/Melkeydev/go-blueprint";
      licence = licenses.mit;
    };
  };
in
  pkgs.writeShellApplication {
    name = "go-blueprint";
    runtimeInputs = with pkgs; [go];
    text = ''
      "${go-blueprint}/bin/go-blueprint" "$@"
    '';
  }
