{outputs, ...}: {
  # This adds overlays and configurations to nixpkgs
  # Adds custom packages from pkgs directory to nixpkgs as a result
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };
}
