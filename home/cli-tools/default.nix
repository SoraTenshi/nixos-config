{ pkgs, ... }: {
  home.packages = with pkgs; [
    ani-cli
    gomuks
    ncdu
    neofetch
    tiny
    tldr
    tmate
    unzip
  ];
}
