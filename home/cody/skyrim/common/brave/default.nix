{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {
        # Ublock Origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      }
      {
        # Dark Reader
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
      }
      {
        # Bitwarden
        id = "nngceckbapebfimnlniiiahkandclblb";
      }
      {
        # All Black Theme
        id = "mkplpffahhkjfocfbfapcemhhkgmljpn";
      }
    ];
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };
}
