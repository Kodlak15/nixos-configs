{
  pkgs,
  config,
  ...
}: let
  pname = "firefox-unwrapped";
in {
  programs.firefox = {
    enable = true;
    # For screen sharing under wayland
    package = pkgs.wrapFirefox (pkgs.${pname}.override {pipewireSupport = true;}) {};
    profiles = {
      kodlak = {
        name = "kodlak";
        id = 0; # Set to 0 to make default profile
        bookmarks = [
          {
            # Bookmarks that will appear on the toolbar
            name = "Toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "GitHub";
                url = "https://github.com/Kodlak15";
              }
              {
                name = "DigitalOcean";
                url = "https://cloud.digitalocean.com";
              }
              {
                name = "ChatGPT";
                url = "https://chatgpt.com/";
              }
              {
                name = "pwn.college";
                url = "https://pwn.college/dojos";
              }
              {
                name = "Chess";
                url = "https://www.chess.com/";
              }
              {
                # Nix resources
                name = "Nix";
                bookmarks = [
                  {
                    name = "NixOS and Flakes Book";
                    url = "https://nixos-and-nix/flakes.thiscute.world/";
                  }
                  {
                    name = "Nix Packages Search";
                    url = "https://search.nixos.org/packages";
                  }
                  {
                    name = "Home Manager Options";
                    url = "https://nix-community.github.io/home-manager/options.xhtml";
                  }
                  {
                    name = "nix.dev";
                    url = "https://nix.dev/";
                  }
                ];
              }
            ];
          }
        ];
        extensions = with config.nur.repos.rycee.firefox-addons; [
          bitwarden
          darkreader
          ublock-origin
        ];
        settings = {
          extensions.autoDisableScopes = 0;
        };
      };
    };
  };
}
