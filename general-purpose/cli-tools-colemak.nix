{ pkgs, ... }:
{
  imports = [
    ./nvim-colemak.nix
    ./helix-colemak.nix
    ./zsh.nix
    ./misc.nix
    ./rss.nix
  ];
}
