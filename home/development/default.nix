{ pkgs, ... }: {
  imports = [ ./common-lisp.nix ];
  home.packages = with pkgs; [
    # debugger
    gdb

    # git
    gitu

    # docker
    lazydocker

    # compiler
    zigpkgs.master
    # zigpkgs."0.13.0"
    odin
    clang
    go

    # Rust
    cargo
    rustc
    clippy
    rustfmt

    # BEAM VM
    elixir
    erlang

    # Python, :(
    python311 # i can't get around it and i'm tired of always using a nix shell

    # cmake
    cmake gnumake

    # Clojure like (for shell scripts)
    joker

    # Qemu
    qemu

    # Nixfmt
    nixfmt-classic
  ];
}
