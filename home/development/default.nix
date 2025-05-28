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
    zig
    odin
    clang
    go

    # Rust
    # cargo
    # rustc
    rustup
    # clippy
    # rustfmt

    # BEAM VM
    elixir
    erlang

    # Python, :(
    python311 # i can't get around it and i'm tired of always using a nix shell
    hy

    # cmake
    cmake gnumake

    # Qemu
    qemu

    # Nixfmt
    nixfmt-classic

    # R stuff (graphing)
    pkgs.R
  ];
}
