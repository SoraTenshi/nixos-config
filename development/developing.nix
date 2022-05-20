{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # tooling
    lazygit git

    # debugger
    gdb

    # compiler
    clang go nim cargo rustc zig

    # cmake
    cmake

    # lsp
    ccls gopls rnix-lsp rust-analyzer zls 
  ];
}
