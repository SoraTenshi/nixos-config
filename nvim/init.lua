vim.g.mapleader = "<SPACE>"

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

function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

function vmap(shortcut, command)
  map('v', shortcut, command)
end

require('init_ll')
require('init_ts')
require('init_bl')
require('init_sh')

require('indent')
require('completion')

require('init_lsp')

-- min width of word
vim.g.cursorword_min_width = 3

-- max width of word
vim.g.cursorword_max_width = 50
vim.g.multi_cursor_use_default_mapping = 1
vim.g.scrolloff = 7

vim.g.tokyonight_style = 'storm'

nmap("<leader>n", "<cmd>:NERDTreeFocus<cr>")
nmap("<C-t>", "<cmd>:NERDTreeToggle<cr>")
nmap("<C-f>", "<cmd>:NERDTreeFind<cr>")

vmap("p", '<cmd>"_dP')
vmap(")<", "<cmd><gv")
vmap(")>", "<cmd>>gv")
vmap("y", "<cmd>myy`y")
vmap("Y", "<cmd>myY`y")

map("", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

nmap("<leader>k", "<cmd>:nohlsearch<cr>")
nmap("<leader>ff", "<cmd>Telescope find_files<cr>")
nmap("<leader>tt", "<cmd>Telescope<cr>")
nmap("<leader>w!", "<cmd>:SudoWrite<cr>")
nmap("<leader>e!", "<cmd>:SudoEdit<cr>")
nmap("<silent>]b", "<cmd>:BufferLineCycleNext<cr>")
nmap("<silent>[b", "<cmd>:BufferLineCyclePrev<cr>")
nmap("<silent><leader>bh", "<cmd>:BufferLineMoveNext<cr>")
nmap("<silent><leader>bl", "<cmd>:BufferLineMovePrev<cr>")

vmap("ga", "<cmd>:EasyAlign<cr>")

vmap("x", '"_x')
nmap("x", '"_x')

vim.cmd([[
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
]])
