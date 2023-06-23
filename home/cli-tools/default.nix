{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xclip
    gomuks
    tldr
    screenfetch
    btop
    tiny
    docker
    ncdu
    imhex
    # OpenPGP 
    gnupg1 gpg-tui pinentry
  ];
}
