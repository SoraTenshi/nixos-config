{ pkgs, ... }: {
  home.packages = [
    pkgs.anki
    pkgs.anki-sync-server
  ];
}
