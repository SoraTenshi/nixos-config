{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  services.xserver.videoDriver = [ "nvidia" ];
  hardware.opengl.enable = true;
}
