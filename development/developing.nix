{ pkgs, zig-overlay, config, ... }:

{
  home.packages = with pkgs; [
    zig-overlay.packages.x86_64-linux.master

    # tooling
    lazygit

    # build zig
    lld_14
    llvmPackages_14.llvm llvmPackages_14.libllvm

    # debugger
    gdb

    # compiler
    clang go nim cargo rustc julia-bin
    idris2 
    
    # interpreter
    nodejs

    # cmake
    cmake 
  ];
}
