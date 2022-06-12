{ pkgs, zig-master, ... }:

{
  home.packages = with pkgs; [
    zig-master.apps.zig

    # tooling
    lazygit

    # build zig
    lld_13
    llvmPackages_13.llvm llvmPackages_13.libllvm

    # debugger
    gdb

    # compiler
    clang go nim cargo rustc zig
    idris2 

    # cmake
    cmake 

    # lsp
    ccls gopls rnix-lsp rust-analyzer zls 
  ];
}
