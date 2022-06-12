{ pkgs, dotfiles, ... }: 
{
  home.packages = with pkgs; [
    helix

    ccls gopls rnix-lsp rust-analyzer zls 
    omnisharp-roslyn sumneko-lua-language-server 

    nodePackages.vim-language-server
    haskell-language-server
  ];

  home.file = {
    ".config/helix" = {
      source = "${dotfiles}/helix";
    };
  };
}
