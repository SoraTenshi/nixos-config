{ pkgs, ... }:
{
  services.xserver = {
    videoDrivers = [ "nvidia" ];
    deviceSection = ''
      Option "TearFree" "true"
    '';
    extraConfig = ''
      Section "Extensions"
        Option "DPMS" "Enable"
      EndSection
    '';
    xrandrHeads = [
      {
        output = "HDMI-0";
        monitorConfig = ''
          Option "Modeline" "1920x1080_60 +990 +0"
          Option "PreferredMode" "1920x1080_60"
          "Position" "990 0"
        '';
      }
      {
        output = "DP-0";
        primary = true;
        monitorConfig = ''
          Option "Modeline" "1920x1080_165 +0 +1080"
          Option "PreferredMode" "1920x1080_165"
          "Position" "0 1080"
        '';
      }
      {
        output = "DP-4";
        monitorConfig = ''
          Option "Modeline" "1920x1080_75 +1920 +1080"
          Option "PreferredMode" "1920x1080_75"
          "Position" "1920 1080"
        '';
      }
    ];
  };
}
