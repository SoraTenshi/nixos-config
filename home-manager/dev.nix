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
      nvim-cmp cmp-buffer cmp-path cmp-nvim-lsp cmp_luasnip lspkind-nvim

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
          rev    =  "f0e80575d0d17e427fca4d54521b38a13a052bb4";
          sha256 =  "05s47267kiwvf85a3c9wpr2phbsacmsg8fy27f6hr58qs5iczlhp";
        };
      in "${repo}/nvim/lua";
    };
  };
}
