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
    # OpenPGP 
    gnupg1 gpg-tui pinentry
  ];
}
