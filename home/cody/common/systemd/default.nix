{pkgs, ...}: {
  systemd.user.services = {
    awww = {
      Install = {
        WantedBy = ["graphical-session.target"];
        After = ["graphical-session-pre.target"];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.awww}/bin/awww-daemon";
        Restart = "always";
      };
    };
  };
}
