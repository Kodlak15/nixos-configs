{pkgs, ...}: {
  # home.packages = [(pkgs.python3Packages.callPackage ../../../../pkgs/swww-manager {})];
  home.packages = [pkgs.swww-manager];
  xdg.configFile."swwwmgr/config.yaml".text = ''
    pywal: true
    transition:
      angle: "45"
      duration: "3"
      position: "center"
      step: "90"
      type: fade
  '';
}
