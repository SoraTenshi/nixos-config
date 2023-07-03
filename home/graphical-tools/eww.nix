{ pkgs, ... }:
{
  programs.eww = {
    enable = true;
    configDir = ./eww;
  };
  
  home.packages = with pkgs; [
    xclip
    wmctrl
    light
    brightnessctl
  ];
}
