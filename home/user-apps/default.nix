{ pkgs, ... }:
{
  home.packages = with pkgs; [
    steam

    discord-canary

    qmk

    vial
  ];
}