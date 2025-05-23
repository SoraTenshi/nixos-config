_: {
  imports = [ ../language-servers ];

  programs.helix = {
    enable = true;
    languages = {
      language-server.superhtml-lsp = {
        command = "superhtml";
        args = ["lsp"];
      };
      language = [
        {
          name = "html";
          scope = "source.html";
          roots = [];
          file-types = [ "html" "shtml" ];
          language-servers = [ "superhtml-lsp" ];
        }
        {
          name = "common-lisp";
          scope = "source.lisp";
          file-types = ["lisp" "asd" "cl" "l" "lsp" "ny" "podsl" "sexp" "ros"];
          shebangs = ["lisp" "sbcl" "ccl" "clisp" "ecl"];
          comment-token = ";";
          indent = { tab-width = 2; unit = "  "; };
          language-servers = [ "cl-lsp" ];
          grammar = "scheme";
        }
      ];
    };
    settings = {
      theme = "tokyonight_storm";
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

        sticky-context = {
          enable = true;
          indicator = false;
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };

        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "error";
        };

        whitespace.render = "all";
        whitespace.characters = {
          space = "·";
          nbsp = "⍽";
          tab = "→";
          newline = "⤶";
        };

        gutters = [ "diagnostics" "line-numbers" "spacer" "diff" ];
        statusline = {
          separator = "of";
          left = [
            "mode"
            "selections"
            "file-type"
            "register"
            "spinner"
            "diagnostics"
          ];
          center = [ "file-name" ];
          right = [
            "file-encoding"
            "file-line-ending"
            "position-percentage"
            "spacer"
            "separator"
            "total-line-numbers"
          ];
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

      keys.normal = {
        "X" = "extend_line_above";
        "C-q" = ":bc";
        "C-d" = [ "half_page_down" "align_view_center" ];
        "C-u" = [ "half_page_up" "align_view_center" ];
      };

      keys.normal."\\" = { "t" = [ ":vs ~/todo.md" ]; };
    };
  };
}
