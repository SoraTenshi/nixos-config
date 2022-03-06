{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # cargo & compiler
    cargo rustc

    # lsp
    rust-analyzer 
  ];
}
