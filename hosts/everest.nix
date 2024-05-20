{config, ...}: {
  imports = [
    ./local/personal/personal.nix
    ./local/personal/everest
  ];

  networking.hostName = "everest";

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
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
    extraGroups = ["wheel" "audio" "video" "input" "docker" "libvirtd" "wireshark"];
    openssh.authorizedKeys.keys = [];
  };

  system.stateVersion = "23.05";
}
