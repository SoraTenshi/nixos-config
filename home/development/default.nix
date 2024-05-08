{ pkgs, ... }: {
  home.packages = with pkgs; [
    # debugger
    gdb

    # git
    tig
    gitu

    # docker
    lazydocker

    # compiler
    zigpkgs.master
    odin
    clang
    cargo
    rustc
    clippy
    rustfmt
    go
    nim
    julia-bin
    ocaml
    opam
    dune-release

    elixir
    erlang
    # swift swiftPackages.swiftpm
    python311 # i can't get around it and i'm tired of always using a nix shell

    idris2

    nasm

    # practice
    exercism

    # cmake
    cmake

    # LISP
    roswell
    babashka
    gerbil

    # Qemu
    qemu

    # Wine
    wine

    # Nixfmt
    nixfmt-classic
  ];
}
