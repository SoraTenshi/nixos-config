{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    vscode
    gdb
  ];

#  home.file = {
#    ".vim/colors/cyberpunk-neon.vim" = {
#      source = let 
#        repo = pkgs.fetchFromGitHub {
#          owner = "roboron3042";
#          repo = "cyberpunk-neon";
#          rev = "fec606df17a5b25634689ded560543246586bac1";
#          sha256 = "08lsccqz8iwslk46cha5cgsvdfc20jkqmmz0rdmnakiyiibk03sa";
#        };
#      in "${repo}/terminal/vim/cyberpunk-neon.vim";
#    };
# };

  programs.neovim = {
    enable = true;
    coc.enable = true;
    vimAlias = true;
    extraConfig = ''
      set clipboard=unnamed
      syntax on
      set backspace=2

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

      colorscheme tokyonight
      set termguicolors
    '';

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      lsp_signature-nvim
      nvim-compe
      vim-easy-align
      vim-multiple-cursors
      zig-vim
			rust-vim
			vim-nix
      nvim-treesitter
      tokyonight-nvim
    ];
  };
}
