{ pkgs, ... }:
{
  imports = [
    ./starship.nix
    ./helix.nix
    ./nvim.nix
    ./zsh.nix
    ./misc.nix
    ./rss.nix
  ];
}
