{ pkgs, zig-master, config, ... }:

{
  home.packages = with pkgs; [
    zig-master.packages.x86_64-linux.master.latest

    # tooling
    lazygit

    # build zig
    lld_13
    llvmPackages_13.llvm llvmPackages_13.libllvm

    # debugger
    gdb

    # compiler
    clang go nim cargo rustc
    idris2 
    
    # interpreter
    nodejs

    # cmake
    cmake 

    # lsp
    ccls gopls rnix-lsp rust-analyzer zls 
    
    # nodepackages lsp
    nodePackages.typescript-language-server
  ];
}
