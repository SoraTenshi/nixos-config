{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    xclip
    gomuks
    tldr
    screenfetch
    gh
  ];
}
