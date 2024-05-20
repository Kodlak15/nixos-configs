{
  pkgs,
  fetchFromGitHub,
  buildPythonPackage,
}:
buildPythonPackage rec {
  pname = "swwwmgr";
  version = "v0.1.1-alpha";

  src = fetchFromGitHub {
    owner = "Kodlak15";
    repo = "swww-manager";
    rev = version;
    hash = "sha256-0FoU1QJ/509pN/qlHx8RWQeVfulO5PlYStBNJwseGUs=";
  };

  propagatedBuildInputs = with pkgs; [python311Packages.pyyaml swww pywal];
}
