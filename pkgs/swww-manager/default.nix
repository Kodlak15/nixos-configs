{
  pkgs,
  fetchFromGitHub,
  buildPythonPackage,
}:
buildPythonPackage rec {
  pname = "swwwmgr";
  version = "v0.1.2-alpha";

  src = fetchFromGitHub {
    owner = "Kodlak15";
    repo = "swww-manager";
    rev = version;
    hash = "sha256-xwQnd2xivTVxns2YH/g+JPWqVVQykK9nx6DTr5CYv14=";
  };

  propagatedBuildInputs = with pkgs; [python312Packages.pyyaml swww pywal];
}
