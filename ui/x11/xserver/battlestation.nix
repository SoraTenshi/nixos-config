{ pkgs, ... }:
{
  hardware.nvidia.forceFullCompositionPipeline = true;

  services.autorandr.enable = true;
  services.xserver = {
    displayManager.sessionCommands = ''
      xrandr --output DVI-D-0 --off \
             --output HDMI-0 --mode 1920x1080 --pos 990x0 --rate 60 --rotate normal \
             --output DP-1 --off \
             --output DP-2 --mode 1920x1080 --pos 1920x1080 --rate 74.99 --rotate normal \
             --output DP-3 --off \
             --output DP-4 --rate 165 --primary --mode 1920x1080 --pos 0x1080 --rotate normal \
             --output DP-5 --off
    '';
  
    synaptics = {
      minSpeed = "0.05";
      accelFactor = null;
    };

    videoDrivers = [ "nvidia" ];
  };
}
