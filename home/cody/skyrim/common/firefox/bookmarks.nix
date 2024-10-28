{
  programs.firefox.profiles.kodlak.bookmarks = [
    {
      # Bookmarks that will appear on the toolbar
      name = "Toolbar";
      toolbar = true;
      bookmarks = [
        {
          name = "CWS";
          url = "https://cascadewebservices.org";
        }
        {
          name = "GitHub";
          url = "https://github.com/Kodlak15";
        }
        {
          name = "DigitalOcean";
          url = "https://cloud.digitalocean.com";
        }
        {
          name = "Hetzner";
          url = "https://www.hetzner.com/";
        }
        {
          name = "AWS";
          url = "https://aws.amazon.com";
        }
        {
          name = "ChatGPT";
          url = "https://chatgpt.com/";
        }
        {
          name = "Claude";
          url = "https://claude.ai/new";
        }
        {
          name = "pwn.college";
          url = "https://pwn.college/dojos";
        }
        {
          name = "cryptohack";
          url = "https://cryptohack.org/courses/";
        }
        {
          name = "htb";
          url = "https://www.hackthebox.com/";
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
              url = "https://nixos-and-flakes.thiscute.world/";
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
        {
          name = "Wayland";
          bookmarks = [
            {
              name = "wlroots";
              url = "https://gitlab.freedesktop.org/wlroots/wlroots";
            }
            {
              name = "river";
              url = "https://github.com/riverwm/river";
            }
          ];
        }
        {
          name = "GameDev";
          bookmarks = [
            {
              name = "Bevy";
              bookmarks = [
                {
                  name = "bevy";
                  url = "https://bevyengine.org/";
                }
                {
                  name = "examples";
                  url = "https://github.com/bevyengine/bevy/tree/latest/examples#examples";
                }
                {
                  name = "cheatbook";
                  url = "https://bevy-cheatbook.github.io/fundamentals.html";
                }
              ];
            }
            {
              name = "blender";
              bookmarks = [
                {
                  name = "manual";
                  url = "https://docs.blender.org/manual/en/dev/";
                }
              ];
            }
          ];
        }
      ];
    }
  ];
}
