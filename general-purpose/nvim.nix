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
    extraPackages = with pkgs; [
      rnix-lsp ripgrep fd tree-sitter sumneko-lua-language-server nodePackages.vim-language-server
      omnisharp-roslyn haskellPackages.ghcide
    ];

    extraConfig = ''
      let mapleader = "\<SPACE>"

      lua << EOF
      local lspconfig = require('lspconfig')
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
      end
      EOF

      lua require('init_ll')
      lua require('init_ts')
      lua require('init_bl')
      lua require('init_sh')

      lua require('indent')
      lua require('completion')

      lua require('init_lsp')

      " min width of word
      let g:cursorword_min_width = 3

      " max width of word
      let g:cursorword_max_width = 50
      let g:multi_cursor_use_default_mapping = 1
      let g:scrolloff = 7

      let g:tokyonight_style = 'storm'

      nnoremap <leader>n :NERDTreeFocus<cr>
      nnoremap <C-t> :NERDTreeToggle<cr>
      nnoremap <C-f> :NERDTreeFind<cr>

      vnoremap p "_dP
      vnoremap < <gv
      vnoremap > >gv
      vnoremap y myy`y
      vnoremap Y myY`y

      noremap <C-k> <cmd>lua vim.lsp.buf.signature_help()<cr>

      nnoremap <leader>k :nohlsearch<cr>
      nnoremap <leader>ff <cmd>Telescope find_files<cr>
      nnoremap <leader>tt <cmd>Telescope<cr>
      nnoremap <leader>w! :SudoWrite<cr>
      nnoremap <leader>e! :SudoEdit<cr>

      nnoremap <silent>]b :BufferLineCycleNext<CR>
      nnoremap <silent>[b :BufferLineCyclePrev<CR>
      nnoremap <silent><leader>bh :BufferLineMoveNext<CR>
      nnoremap <silent><leader>bl :BufferLineMovePrev<CR>

      vnoremap ga :EasyAlign<cr>

      vnoremap x "_x
      nnoremap x "_x

      set clipboard+=unnamedplus
      syntax on
      set hidden
      set nobackup
      set signcolumn=yes:2
      set nowritebackup
      set cmdheight=2
      set updatetime=300
      set shortmess+=c
      set backspace=2
      set visualbell
      set t_vb=
      set title
      set relativenumber
      set number
      set ruler
      set tabstop=2 shiftwidth=2 smarttab expandtab
      set noexpandtab
      set cursorline
      set encoding=UTF-8
      set smartcase
      set smartindent
      set ignorecase
      set cursorline
      set updatetime=300
      set redrawtime=10000
      set ve=all

      colorscheme tokyonight
    '';
  };

  home.file = {
    ".config/nvim/lua" = {
      source = "${dotfiles}/nvim/lua";
    };
  };
}
