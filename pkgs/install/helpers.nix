{pkgs, ...}: {
  rbtohex =
    pkgs.writeShellScriptBin
    "rbtohex"
    ''( od -An -vtx1 | tr -d ' \n' )'';
  hextorb =
    pkgs.writeShellScriptBin
    "hextorb"
    ''( tr '[:lower:]' '[:upper:]' | sed -e 's/\([0-9A-F]\{2\}\)/\\\\\\x\1/gI'| xargs printf )'';
  pbkdf2Sha512 = pkgs.callPackage ./pbkdf2-sha512.nix {};
}
