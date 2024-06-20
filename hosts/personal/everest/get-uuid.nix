{pkgs, ...}: let
  getUuid = pkgs.writeShellScriptBin "get_uuid.sh" ''
    blkid /dev/mapper/nixos-crypt | awk -F 'UUID="' '{print $2}' | awk -F '"' '{print $1}'
  '';
in
  pkgs.runCommand "uuid" {} ''
    output=$(bash ${getUuid}/bin/get_uuid.sh)
    echo "$output" > $out
  ''
