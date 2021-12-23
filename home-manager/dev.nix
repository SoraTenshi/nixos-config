{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neovim
#    vscode
  ];

  programs.neovim = {
    enable = true;
    coc.enable = true;
    extraConfig = ''
      set clipboard += unnamedplus
      syntax on
      set backspace = 2

      set visualbell
      set t_vb=

      set relativenumber
      set number

      set ruler

      set tabstop=2 smarttab
      set cursorline
      set encoding=UTF-8
      set smartcase
      set smartindent
      set ignorecase
      set cursorline

      nnoremap x "_d
      nnoremap xx "_dd"
    '';
    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      nvim-treesitter
      lsp_signature-nvim
      nvim-compe
      vim-easy-align
      vim-multiple-cursors
    ];
  };

}
