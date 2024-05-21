{
  lib,
  stdenv,
  fetchurl,
}: let
  # Credit to rycee: https://github.com/nix-community/nur-combined/tree/master/repos/rycee
  buildFirefoxXpiAddon = lib.makeOverridable ({
    pname,
    version,
    addonId,
    url,
    sha256,
    meta,
    ...
  }:
    stdenv.mkDerivation {
      name = "${pname}-${version}";

      inherit meta;

      src = fetchurl {inherit url sha256;};

      preferLocalBuild = true;
      allowSubstitutes = true;

      passthru = {inherit addonId;};

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
    });
in
  buildFirefoxXpiAddon {
    pname = "dark-space";
    version = "v1.1.2";
    addonId = "{22b0eca1-8c02-4c0d-a5d7-6604ddd9836e}";
    url = "https://addons.mozilla.org/firefox/downloads/file/4226329/nicothin_space-1.1.2.xpi";
    sha256 = "R7KFyeJhLVs7KsNiD34B/Yr88pp7rClvjZcHeDDN2XI=";
    meta = {};
  }
