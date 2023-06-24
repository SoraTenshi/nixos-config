{ ... }:
{
  imports = [
    ../language-servers
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight_storm";
      icons = "nerdfonts";
      editor = {
        line-number = "relative";
        cursorline = true;
        scrolloff = 5;
        color-modes = true;
        idle-timeout = 1;
        true-color = true;
        rainbow-brackets = true;
        bufferline = "always";
        rulers = [ 100 ];
        popup-border = "all";
        soft-wrap.enable = true;
        completion-replace = true;
        cursor-word = true;

        sticky-context = {
          enable = true;
          indicator = true;
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
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
          mode-separator = "";
          separator = "";
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
          rainbow-option = "normal";
        };
      };
      keys = {
        "supertab" = "move_parent_node_end";
      };

      keys.normal = {
        "X" = "extend_line_above";
        "C-q" = ":bc";
        "C-d" = ["half_page_down" "align_view_center"];
        "C-u" = ["half_page_up" "align_view_center"];
      };
    };
  };
  

}
