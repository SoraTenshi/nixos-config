{ self, pkgs, ... }:
{
  programs.eww = {
    enable = true;
    configDir = ../../eww;
  };
  
  home.packages = with pkgs; [
    wmctrl
    light
    brightnessctl
  ];
}

