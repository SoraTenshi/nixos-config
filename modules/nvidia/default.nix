{ pkgs, config, ... }:
{
  hardware.nvidia = {
    powerManagement.enable = true;
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
