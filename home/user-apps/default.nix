{ pkgs, ... }:
{
  home.packages = with pkgs; [
    steam

    discord-canary

    qmk vial

    firefox
    mumble
    zathura
    keepassxc
    dino
    spacedrive
  ];
}
