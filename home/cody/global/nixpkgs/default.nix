{outputs, ...}: {
  # This adds overlays and configurations to nixpkgs
  # Adds custom packages from pkgs directory to nixpkgs as a result
  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      # TODO temporary solution
      permittedInsecurePackages = ["electron-27.3.11" "electron-28.3.3"];
    };
  };
}
