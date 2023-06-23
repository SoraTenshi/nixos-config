{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # tooling
    lazygit delta

    # debugger
    gdb

    # compiler
    zigpkgs.master
    odin
    clang
    cargo rustc
    go
    nim
    julia-bin

    elixir erlang 
    swift swiftPackages.swiftpm

    idris2 

    nasm

    nodejs

    # practice
    exercism

    # cmake
    cmake mmake
  ];
}
