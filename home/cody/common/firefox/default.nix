{pkgs, ...}: let
  # TODO: need to figure this out
  addons = pkgs.nur.repos.rycee.firefox-addons;
in {
  imports = [
    ./policies.nix
    ./bookmarks.nix
  ];

  programs.firefox = {
    enable = true;
    profiles = {
      kodlak = {
        name = "kodlak";
        id = 0; # Set to 0 to make default profile
        # TODO: need to figure this out (see above and in flake.nix overlays)
        extensions = with addons; [
          bitwarden
          darkreader
          ublock-origin
        ];
        settings = {
          extensions.autoDisableScopes = 0;
        };
        search = {
          default = "DuckDuckGo";
          force = true;
          engines = {
            "Nix Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@np"];
            };
            "NixOS Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = ["@nixopts"];
            };
          };
        };
      };
    };
  };
}
