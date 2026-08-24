{ pkgs, ... }: {
  imports = [ ./rice.nix ];
  home.packages = with pkgs; [
    ani-cli
    pkgsStatic.cachix
    pkgsStatic.magic-wormhole
    pkgsStatic.ncdu
    pkgsStatic.tiny
    pkgsStatic.tldr
    pkgsStatic.tmate
    pkgsStatic.unzip
    pkgsStatic.tailspin
  ];
}
