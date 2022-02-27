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
      lua require('completion')

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
          rev    =  "b56c3f6fda07b9528825d6066484bee2df2d270c";
          sha256 =  "1yz1qrracx5j4w6sl2a0vwhk4li5nqa3fa2qp50970an6xqqqnw1";
        };
      in "${repo}/nvim/lua";
    };
  };
}
