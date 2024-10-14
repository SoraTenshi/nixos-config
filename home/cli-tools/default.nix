{ pkgs, ... }: {
  imports = [ ./rice.nix ];
  home.packages = with pkgs; [
    ani-cli
    bitwarden-cli
    bws
    magic-wormhole
    ncdu
    tiny
    tldr
    tmate
    unzip
  ];
}
