{ config, pkgs, dotfiles, neovim-nightly, ... }:

{
  nixpkgs.overlays = neovim-nightly;

  programs.neovim = {
    enable        = true;
    vimAlias      = true;
    viAlias       = true;
    vimdiffAlias  = true;

    plugins = with pkgs.vimPlugins; [
      # utilities
      telescope-nvim vim-easy-align vim-multiple-cursors vim-commentary vim-css-color vim-devicons which-key-nvim vim-eunuch vim-cursorword
      # visual 
      nerdtree
      lualine-nvim lualine-lsp-progress
      # buffer stuff
      bufferline-nvim
      # auto complete
      nvim-cmp cmp-buffer cmp-path lspkind-nvim nvim-lspconfig lsp_signature-nvim cmp_luasnip luasnip cmp-nvim-lsp
      # syntax highlighting
      vim-polyglot
      # design stuff
      tokyonight-nvim indent-blankline-nvim
      # tree sitter
      (nvim-treesitter.withPlugins (_: with plugins; pkgs.tree-sitter.allGrammars)) nvim-ts-rainbow
    ];
  };

  xdg.configFile."nvim" = {
    source = "${self}/nvim";
    recursive = true;
  };
}
