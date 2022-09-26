{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
    ./user-apps.nix
    ./dunst.nix
  ];
}
