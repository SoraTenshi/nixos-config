{ pkgs, ... }:
{
  services.xserver.displayManager.sddm.setupScript = ''
    xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 992x0 --rotate normal --output DP-0 --primary --mode 1920x1080 --pos 0x1080 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --mode 1920x1080 --pos 1920x1080 --rotate normal --output DP-5 --off
  '';
}
