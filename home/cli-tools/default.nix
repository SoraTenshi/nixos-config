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
  ] ++ (if system == "x86_64-linux" then with pkgs; [
      bitwarden-cli
  ] else []);
}
