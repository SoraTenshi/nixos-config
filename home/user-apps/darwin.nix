{ pkgs, ... }:
{
  home.packages = with pkgs; [
    qmk
    discord-canary
  ];
}
