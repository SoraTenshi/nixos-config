{ pkgs, lib, dotfiles, helix-master, ... }:
{
  programs.helix = {
    enable = true;
    package = helix-master.packages."x86_64-linux".default;
    settings = {
      theme = "tokyonight_storm";
      editor = {
        line-number = "relative";
        cursorline = true;
        scrolloff = 10;
        color-modes = true;
        idle-timeout = 1;
        true-color = true;
        shell = [ "zsh" ];
        lsp.display-messages = true;
        cursor-shape.insert = "bar";
        whitespace.render = "all";
        whitespace.characters = {
          space = "·";
          nbsp = "⍽";
          tab = "→";
          newline = "⤶";
        };
        statusline = {
          left = [ "mode" "spinner" "file-name" ];
          center = [ ];
          right = [ "diagnostics" "file-encoding" "file-line-ending" "file-type" "position" "selections" ];
        };
        indent-guides = {
          render = true;
        };
      };
      keys.normal = {
        "X" = "extend_line_above";
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        "y" = "yank_main_selection_to_clipboard";
      };
    };
  };

  home.packages = with pkgs; [
    # Debugging stuff
    lldb

    # Language servers
    clang-tools # C-Style
    cmake-language-server # Cmake
    texlab # LaTeX
    gopls # Go 
    rnix-lsp # Nix
    rust-analyzer
    zls # Zig
    omnisharp-roslyn # .NET 
    sumneko-lua-language-server # Lua
    nodePackages.vim-language-server
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
    haskell-language-server
  ];
}
