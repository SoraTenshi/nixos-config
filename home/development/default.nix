{ pkgs, ... }:
{
  home.packages = with pkgs; [
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
    ocaml opam dune-release

    elixir erlang 
    swift swiftPackages.swiftpm

    idris2 

    nasm

    nodejs

    # practice
    exercism

    # cmake
    cmake gnumake
  ];
}
