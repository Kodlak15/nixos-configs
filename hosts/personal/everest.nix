{config, ...}: {
  imports = [
    ./personal.nix
    ./everest
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
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  users.users.cody = {
    initialPassword = "towerponyforestjeep";
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "input"
      "docker"
      "libvirtd"
      "wireshark"
      "usb"
      "plugdev"
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [];
  };

  system.stateVersion = "23.05";
}
