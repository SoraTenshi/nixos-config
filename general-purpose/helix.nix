{ self, pkgs, lib, helix-master, ... }:
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
        rainbow-brackets = true;
        lsp.display-messages = true;
        bufferline = "always";
        sticky-context = true;
        rulers = [ 80 ];
        popup-border = "all";
        
        explorer = {
          position = "embed";
        };

        whitespace.render = "all";
        whitespace.characters = {
          space = "·";
          nbsp = "⍽";
          tab = "→";
          newline = "⤶";
        };

        gutters = [ "diagnostics" "line-numbers" "spacer" "diff"];
        statusline = {
          separator = "|";
          left = [ "mode" "selections" "spinner" "file-name" "total-line-numbers"];
          center = [ ];
          right = [ "diagnostics" "file-encoding" "file-line-ending" "file-type" "position-percentage"  "position" ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
        indent-guides = {
          render = true;
          rainbow = "normal";
        };
      };
      keys.normal = {
        "X" = "extend_line_above";
        "C-q" = ":bc";
        "C-d" = ["half_page_down" "align_view_center"];
        "C-u" = ["half_page_up" "align_view_center"];
      };
    };
  };
  
  home.packages = with pkgs; [
    # Formatting
    alejandra
    
    # Debugging stuff
    lldb

    # Language servers
    clang-tools # C-Style
    # cmake-language-server # Cmake
    gopls # Go 
    nil # Nix
    rust-analyzer # Rust
    texlab # LaTeX
    zls # Zig
    elixir_ls # Elixir
    # omnisharp-roslyn # .NET 
    haskellPackages.haskell-language-server # Haskell
    nodePackages.typescript-language-server # Typescript
    nodePackages.vim-language-server # Vim
    nodePackages.yaml-language-server # YAML / JSON
    sumneko-lua-language-server # Lua
  ];
}
