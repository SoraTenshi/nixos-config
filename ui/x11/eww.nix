{ pkgs, ... }:
{
  programs.eww = {
    enable = true;
    configDir = ../../home/eww/eww;
  };
  
  home.packages = with pkgs; [
    xclip
    wmctrl
    light
    brightnessctl
  ];
}

