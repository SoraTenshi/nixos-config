{ pkgs, ... }:
{
  imports = [
    ./helix.nix
    ./nvim.nix
    ./zsh.nix
    ./misc.nix
  ];
}
