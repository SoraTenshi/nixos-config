{ pkgs, ... }:
{
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    deviceSection = ''
      Option "TearFree" "true"
    '';
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
