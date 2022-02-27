{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    gdb

    # Runtimes
    # fix this 
    # cargo gcc clang go pythonFull 
    git
    zig zls
    lazygit

    # nix utils
    nix-prefetch-github
  ];

  programs.neovim = {
    enable = true;
    coc.enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      vim-easy-align
      vim-multiple-cursors
      nvim-treesitter
      nvim-tree-lua

      # auto complete
      nvim-cmp cmp-buffer cmp-path cmp-nvim-lsp cmp_luasnip

      # syntax highlighting
      zig-vim rust-vim vim-nix

      # design stuff
      tokyonight-nvim
      indent-blankline-nvim
    ];

    extraConfig = ''
      lua require('indent')

      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>

      vnoremap x "_x
      nnoremap x "_x

      set clipboard+=unnamedplus
      syntax on
      set backspace=2

      set visualbell
      set t_vb=

      set relativenumber
      set number
      set ignorecase

      set ruler

      set tabstop=2 smarttab
      set cursorline
      set encoding=UTF-8
      set smartcase
      set smartindent
      set ignorecase
      set cursorline

      colorscheme tokyonight
      set termguicolors
    '';
  };

  home.file = {
    ".config/nvim/lua" = {
      source = let
        repo = pkgs.fetchFromGitHub {
          owner  =  "s0la1337";
          repo   =  "dotfiles";
          rev    =  "b3ee58b1654676ffc2bb9c4ac202e28b62e33dea";
          sha256 =  "1bzvwivrkbc4abmg98xxcxp6gwb250b57l4vvryj2f4gq482671p";
        };
      in "${repo}/nvim/lua";
    };
  };
}
