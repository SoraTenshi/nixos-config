{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./user-apps.nix
    ./dunst.nix
  ];
}
