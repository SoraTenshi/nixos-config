{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # debugger
    gdb

    # compiler
    clang

    # lsp
    clang-analyzer
  ];
}
