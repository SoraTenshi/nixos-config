{ pkgs, ... }: {
  imports = [ ./rice.nix ];
  home.packages = with pkgs; [
    ani-cli
    bitwarden-cli
    bws
    ncdu
    tiny
    tldr
    tmate
    unzip
  ];
}
