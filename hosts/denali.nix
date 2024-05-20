{config, ...}: {
  imports = [
    ./local/personal/personal.nix
    ./local/personal/denali
  ];

  networking.hostName = "denali";

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  users.users.cody = {
    initialPassword = "towerponyforestjeep";
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "video" "input" "dialout" "docker" "libvirtd" "wireshark"];
    openssh.authorizedKeys.keys = [];
  };

  system.stateVersion = "23.05";
}
