{ pkgs, ... }:
{
  imports = [
    ./wezterm.nix
    ./kitty.nix
    ./user-apps.nix
    ./dunst.nix
  ];
}
