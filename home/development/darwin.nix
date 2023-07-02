{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lazydocker

    # some commonly used compiler stuff
    zigpkgs.master
    guile
    cargo rustc
    go
    elixir
  ];
}
