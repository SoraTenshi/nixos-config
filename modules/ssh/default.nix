{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    opensc
  ];

  virtualisation.docker.enable = true;

  services.openssh.enable = true;
  services.pcscd.enable = true;

  programs.ssh = {
    startAgent = true;
    agentPKCS11Whitelist = "${pkgs.opensc}/lib/opensc-pkcs11.so";
  };
}
