{ pkgs, ... }:
{
  services.xserver = {
    deviceSection = ''
      Option "TearFree" "true"
    '';
    
    xrandrHeads = [
      {
        output = "HDMI-0";
        # monitorConfig = ''
        #   \"Position\" \"990 0\"
        # '';
      }
      {
        output = "DP-0";
        primary = true;
        # monitorConfig = ''
        #   \"Position\" \"0 1080\"
        # '';
      }
      {
        output = "DP-4";
        # monitorConfig = ''
        #   Option \"Position\" \"1920 1080\"
        # '';
      }
    ];
  };
}
