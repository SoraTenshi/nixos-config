{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # debugger
    gdb

    # compiler
    clang

    # cmake
    cmake

    # lsp
    ccls
  ];
}
