{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # tooling
    lazygit

    # debugger
    gdb

    # compiler
    clang go nim cargo rustc zig

    # lsp
    ccls gopls rnix-lsp rust-analyzer zls 
  ];
}
