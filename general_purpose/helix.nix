{ pkgs, dotfiles, ... }: 
{
  home.packages = with pkgs; [
    # Helix as main package
    helix
    
    # Debugging stuff
    lldb

    # Language servers
    clangd # C-Style
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

  home.file = {
    ".config/helix/config.toml" = {
      source = ''
theme = "tokyonight_storm"

[editor]
line-number = "relative"
scrolloff = 10
idle-timeout = 200
true-color = true

[editor.cursor-shape]
insert = "bar"

[editor.auto-pairs]
'(' = ')'
'{' = '}'
'[' = ']'
'"' = '"'
'`' = '`'
'<' = '>'

[editor.whitespace]
render = "all"

[editor.whitespace.characters]
space = "·"
nbsp = "⍽"
tab = "→"
newline = "⏎"
      '';
    };
    ".config/helix/language.toml" = {
      source = ''
use-grammars = { }
      '';
    };
   };
}
