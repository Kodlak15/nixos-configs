{pkgs, ...}: {
  postgresql = {
    enable = true;
    ensureDatabases = ["mydb"];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host  all       all     192.168.122.1/32 trust
      host  all       all     172.17.0.0/16    trust
      host  all       all     ::1/128          trust
    '';
    enableTCPIP = true;
  };
}
