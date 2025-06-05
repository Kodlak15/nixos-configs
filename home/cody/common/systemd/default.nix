{pkgs, ...}: {
  systemd.user.services = {
    swww = {
      Install = {
        WantedBy = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "always";
      };
    };
  };
}
