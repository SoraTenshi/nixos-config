{pkgs, ...}: {
  home.packages = [
    pkgs.elvish
    pkgs.murex
  ];
}
