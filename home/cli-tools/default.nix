{ pkgs, ... }: {
  imports = [ ./rice.nix ];
  home.packages = with pkgs; [
    ani-cli
    bitwarden-cli
    bws
    cachix
    magic-wormhole
    ncdu
    tiny
    tldr
    tmate
    unzip
  ];
}
