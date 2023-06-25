{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # i am lazy lmao
    lazygit lazydocker

    # some commonly used compiler stuff
    zigpkgs.master
    cargo rustc
    go
    elixir
  ];
}
