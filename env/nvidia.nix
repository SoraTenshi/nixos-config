{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  hardware.opengl.enable = true;
}
