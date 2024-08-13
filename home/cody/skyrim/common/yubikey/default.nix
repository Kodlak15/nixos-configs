{pkgs, ...}: {
  home.packages = with pkgs; [
    yubikey-personalization
    yubico-pam
    yubikey-manager
    yubioath-flutter
  ];
}
