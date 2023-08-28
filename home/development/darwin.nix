{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnumake
    lazydocker

    # some commonly used compiler stuff
    zigpkgs.master
    guile
    cargo rustc
    go
    elixir
  ];
}
