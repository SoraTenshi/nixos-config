{ pkgs, lib, dotfiles, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight_storm";
      editor = {
        line-number = "relative";
        scrolloff = 10;
        idle-timeout = 200;
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
      };
      keys.normal = {
        "j" = "move_line_down";
        "k" = "move_line_up";
        "l" = "move_char_right";
        "w" = "move_next_word_start";
        "b" = "move_prev_word_start";
        "e" = "move_next_word_end";
        "W" = "move_next_long_word_start";
        "B" = "move_prev_long_word_start";
        "E" = "move_next_long_word_end";
        "t" = "find_till_char";
        "f" = "find_next_char";
        "T" = "till_prev_char";
        "F" = "find_prev_char";
        "G" = "goto_line";
        "C-b" = "page_up";
        "C-f" = "page_down";
        "C-u" = "half_page_up";
        "C-d" = "half_page_down";
        "C-i" = "jump_forward";
        "C-o" = "jump_backward";
        "C-s" = "save_selection";
        "X" = "extend_line_above";
        "{" = "goto_prev_paragraph";
        "}" = "goto_next_paragraph";
        "y" = "yank_main_selection_to_clipboard";
      };
      
      keys.changes = {
        "p" = "replace";
        "P" = "replace_with_yanked";
        "~" = "switch_case";
        "`" = "switch_to_lowercase";
        "Alt-`" = "switch_to_uppercase";
        "u" = "insert_mode";
        "U" = "prepend_to_line";
        "d" = "delete_selection";
        "Alt-d" = "delection_selection_noyank";
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
    haskell-language-server
  ];
}
