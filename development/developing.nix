{ pkgs, zig-master, config, ... }:

{
  home.packages = with pkgs; [
    zig-master.packages.x86_64-linux.master.latest

    # tooling
    lazygit

    # build zig
    lld_14
    llvmPackages_14.llvm llvmPackages_14.libllvm

    # debugger
    gdb

    # compiler
    clang go nim cargo rustc julia_17-bin
    idris2 
    
    # interpreter
    nodejs

    # cmake
    cmake 
  ];
}
