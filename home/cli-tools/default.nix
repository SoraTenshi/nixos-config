{ pkgs, ... }: {
  imports = [ ./rice.nix ];
  home.packages = with pkgs; [
    ani-cli
    bws
    cachix
    magic-wormhole
    ncdu
    tiny
    tldr
    tmate
    unzip
    tailspin
  ];
}
