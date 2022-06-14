{ pkgs, lib, dotfiles, ... }: 
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight_storm";
      editor = {
        line-number = "relative";
        scrolloff = 10;
        idle-timeout = 200;
        true-color = true;
        cursor-shape.insert = "bar";
        whitespace.render = "all";
        whitespace.characters = {
          space = "·";
          nbsp = "⍽";
          tab = "→";
          newline = "⤶";
        };
      };
    };
  };
  
  home.packages = with pkgs; [
    # Debugging stuff
    lldb

    # Language servers
    clang-tools # C-Style
    cmake-language-server # Cmake
    texlab # LaTeX
    gopls # Go 
    rnix-lsp # Nix
    rust-analyzer 
    zls # Zig
    omnisharp-roslyn # .NET 
    sumneko-lua-language-server # Lua
    nodePackages.vim-language-server
    nodePackages.typescript-language-server
    haskell-language-server
  ];
}
