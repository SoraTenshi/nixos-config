{ pkgs, ... }:
{
  hardware.nvidia.forceFullCompositionPipeline = true;

  services.autorandr.enable = true;
  services.xserver = {
    displayManager.sessionCommands = ''
      xrandr --output DVI-D-0 --off \
             --output HDMI-0 --mode 1920x1080 --pos 990x0 --rate 60 --rotate normal \
             --output DP-0 --rate 165 --primary --mode 1920x1080 --pos 0x1080 --rotate normal \
             --output DP-1 --off \
             --output DP-2 --off \
             --output DP-3 --off \
             --output DP-4 --mode 1920x1080 --pos 1920x1080 --rate 75 --rotate normal --output DP-5 --off
    '';
  
    synaptics = {
      minSpeed = "0.05";
      accelFactor = null;
    };

    videoDrivers = [ "nvidia" ];
    xrandrHeads = [
      {
        output = "DP-0";
        primary = true;
        monitorConfig = ''
          Option "Position" "0 1080"
          Option "PreferredMode" "1920x1080@165"
        '';
      }
      {
        output = "HDMI-0";
        monitorConfig = ''
          Option "Position" "990 0"
          Option "PreferredMode" "1920x1080@60"
        '';
      }
      {
        output = "DP-4";
        monitorConfig = ''
          Option "Position" "1920 1080"
          Option "PreferredMode" "1920x1080@75"
        '';
      }
    ];
    exportConfiguration = true;
  };
}
