{ pkgs, ... }:
{
  imports = [
    ./kakoune.nix
    ./helix.nix
    # ./emacs.nix
    ./nvim.nix
    ./zsh.nix
    ./misc.nix
    ./rss.nix
  ];
}
