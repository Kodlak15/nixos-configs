{
  pkgs,
  fetchFromGitHub,
}: let
  # TODO
  # -> Would be nice to find a way to use the rust-overlay when needed (for nightly builds, as an example)
  # -> Would it be more convenient/reasonable to use nix/flakes for this instead?
  rustPlatform = pkgs.makeRustPlatform {
    cargo = pkgs.cargo;
    rustc = pkgs.rustc;
  };
in
  rustPlatform.buildRustPackage rec {
    name = "openweathercli";
    pname = "openweathercli";
    version = "v0.2.0-alpha";

    src = fetchFromGitHub {
      owner = "Kodlak15";
      repo = "openweathercli";
      rev = version;
      # hash = "sha256-AEsoYFq6j0VVYyuDypNijjhldd7DBUpZwj6xriBjSBM=";
      hash = "sha256-u8RH9hi41ZJVjqyNsGhbyAYadxZ0SBmp5XFFjZmgaao=";
    };

    cargoLock = {
      lockFile = ./Cargo.lock;
    };

    nativeBuildInputs = with pkgs; [pkg-config];
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
  }
