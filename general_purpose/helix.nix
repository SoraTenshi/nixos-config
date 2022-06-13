{ pkgs, dotfiles, ... }: 
{
  home.packages = with pkgs; [
    # Helix as main package
    helix

    # Language servers
    ccls 
    gopls 
    rnix-lsp 
    rust-analyzer 
    zls 
    omnisharp-roslyn 
    sumneko-lua-language-server 
    nodePackages.vim-language-server
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
