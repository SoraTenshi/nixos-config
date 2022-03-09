{ config, pkgs, dotfiles, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # utilities
      telescope-nvim vim-easy-align vim-multiple-cursors vim-commentary vim-css-color vim-devicons

      # status bar
      vim-airline vim-airline-clock 

      # auto complete
      nvim-cmp cmp-buffer cmp-path cmp-nvim-lsp cmp_luasnip lspkind-nvim nvim-lspconfig
      vim-lightline-coc telescope-coc-nvim 

      # syntax highlighting
      zig-vim vim-nix
      vim-polyglot 

      # design stuff
      tokyonight-nvim
      indent-blankline-nvim
    ];

    extraConfig = ''
      lua require('indent')
      lua require('completion')
      lua require('zls')

      xmap ga <Plug>(EasyAlign)
      nmap ga <Plug>(EasyAlign)
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>fb <cmd>Telescope buffers<cr>

      noremap n j
      noremap e k
      noremap l i
      noremap i l
      noremap k n
      noremap j e
      vnoremap x "_x
      nnoremap x "_x
      set clipboard+=unnamedplus
      syntax on
      set hidden
      set nobackup
      set nowritebackup
      set cmdheight=2
      set updatetime=300
      set shortmess+=c
      set backspace=2
      set visualbell
      set t_vb=
      set relativenumber
      set number
      set ignorecase
      set ruler
      set tabstop=2 shiftwidth=2 smarttab
      set noexpandtab
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
      source = "${dotfiles}/nvim/lua";
    };
  };
}
