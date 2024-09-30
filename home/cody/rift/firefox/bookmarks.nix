{
  programs.firefox.profiles.kodlak.bookmarks = [
    {
      # Bookmarks that will appear on the toolbar
      name = "Toolbar";
      toolbar = true;
      bookmarks = [
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
          name = "htb";
          url = "https://www.hackthebox.com/";
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
      ];
    }
  ];
}
