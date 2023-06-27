{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lazydocker

    # some commonly used compiler stuff
    zigpkgs.master
    cargo rustc
    go
    elixir
  ];
}
