{ pkgs, ... }:
{
  imports = [
    ./helix-colemak.nix
    ./zsh.nix
    ./misc.nix
    ./rss.nix
  ];
}
