{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xclip
    gomuks
    tldr
    screenfetch
    gh
    jq
    btop
    tiny
    gptcommit
    docker
    ncdu
  ];
}
