{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gomuks
    tldr
    screenfetch
    btop
    tiny
    ncdu
  ];
}
