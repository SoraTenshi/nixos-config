_: {
  services.distccd = {
    enable = true;
    openFirewall = true;
    allowedClients = [ "127.0.0.1" "192.168.0.0/24" ];
  };
}
