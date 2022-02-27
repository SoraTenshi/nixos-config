{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    vscode
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
      nvim-compe
      vim-easy-align
      vim-multiple-cursors
      nvim-treesitter
      nvim-tree-lua

      # language specific 
      nvim-cmp
      cmp-nvim-lsp
      cmp_luasnip lspkind-nvim
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
          rev    =  "d56b2c0ff783e6fefc738553202580ade6869cb8";
          sha256 =  "0ag35vmwnfi71fzdw2kp1h2hikpdgdr1picb1g2z7l8qah6ivjzd";
        };
      in "${repo}/nvim/lua";
    };
  };
}

