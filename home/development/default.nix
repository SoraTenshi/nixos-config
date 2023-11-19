{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # debugger
    gdb

    # compiler
    zigpkgs.master
    odin
    clang
    cargo rustc clippy rustfmt
    go
    nim
    julia-bin
    ocaml opam dune-release

    elixir erlang 
    # swift swiftPackages.swiftpm
    python311 # i can't get around it and i'm tired of always using a nix shell

    idris2 

    nasm

    nodejs

    # practice
    exercism

    # cmake
    cmake gnumake
  ];
}
