{ pkgs, system, ... }:
let
  defaultSet = [
    pkgs.zig
    pkgs.rustup
    pkgs.go
    pkgs.elixir

    # Python, sadly i am too annoyed by
    # creating a nix shell all the time
    # i have to write something with python :(
    pkgs.python3Minimal pkgs.hy
  ];
in
{
  imports = [ ./common-lisp.nix ];
  home.packages = defaultSet ++ (if system == "x86_64-linux" then [
    # debugger
    pkgs.gdb

    # git
    pkgs.gitu

    pkgs.odin

    pkgs.clang

    # cmake
    pkgs.cmake pkgs.gnumake

    # Qemu
    pkgs.qemu

    # Nixfmt
    pkgs.nixfmt-classic

    # R stuff (graphing)
    pkgs.R

    # i am so sick of this dependency...
    pkgs.openssl pkgs.pkg-config
  ] else []);
}
