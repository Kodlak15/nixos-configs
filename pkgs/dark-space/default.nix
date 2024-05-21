let
  firefox-addons = builtins.fetchurl {
    # url = "https://github.com/nix-community/nur-combined/blob/master/repos/rycee/pkgs/firefox-addons";
    url = "https://raw.githubusercontent.com/nix-community/nur-combined/master/repos/rycee/pkgs/firefox-addons/default.nix";
    sha256 = "1svb9l8cf7bmjvmxwp15bm5cjbgyvda72cy856n1v46g7ill53ax";
  };
in
  firefox-addons.buildFirefoxXpiAddon {
    pname = "ddark-space";
    version = "v1.1.2";
    addonId = "{22b0eca1-8c02-4c0d-a5d7-6604ddd9836e}";
    url = "https://addons.mozilla.org/firefox/downloads/file/4226329/nicothin_space-1.1.2.xpi";
    sha256 = "0k82mjqxdm0gdgm13mviflwks2n3s8d267s53d8p4wgaqsa4kjnj";
  }
