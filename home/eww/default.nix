{pkgs, ...}: {
  programs.eww = {
    enable = true;
    configDir = ./eww;
  };

  home.packages = [
    pkgs.xclip
    pkgs.wmctrl
    pkgs.light
    pkgs.brightnessctl
  ];
}
