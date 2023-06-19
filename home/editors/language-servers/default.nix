{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Formatting
    alejandra
    
    # Debugging stuff
    lldb

    # Language servers
    clang-tools # C-Style
    # cmake-language-server # Cmake
    gopls # Go 
    nil # Nix
    rust-analyzer # Rust
    texlab # LaTeX
    zls # Zig
    elixir_ls # Elixir
    sourcekit-lsp # Swift & Obj-C
    # omnisharp-roslyn # .NET 
    haskellPackages.haskell-language-server # Haskell
    nodePackages.typescript-language-server # Typescript
    nodePackages.vim-language-server # Vim
    nodePackages.yaml-language-server # YAML / JSON
    luajitPackages.lua-lsp # Lua
  ];
}
