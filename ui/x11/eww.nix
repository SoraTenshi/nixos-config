{ pkgs, ... }:
{
  programs.eww = {
    enable = true;
    configDir = ../../eww;
  };
  
  environment.systemPackages = with pkgs; [
    wmctrl
    brightnessctl
  ];
}

