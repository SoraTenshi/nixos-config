{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    gdb

    # Runtimes
    # fix this 
    cargo clang go pythonFull rustc
    zig swift 

    # lsp
    zls clang-analyzer rust-analyzer 

    # source version control
    git
    lazygit

    # nix utils
    nix-prefetch-github
  ];
}
