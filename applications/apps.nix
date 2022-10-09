{ pkgs, ... }:
{
  imports = [
    ./kitty.nix
    ./user-apps.nix
    ./dunst.nix
  ];
}
