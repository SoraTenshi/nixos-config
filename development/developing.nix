{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # tooling
    lazygit llvm libllvm

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
