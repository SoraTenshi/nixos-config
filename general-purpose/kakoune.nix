{ self, config, pkgs, ... }:

{
  programs.kakoune = {
    enable = true;
    config = {
      indentWidth = 2;
      showMatching = true;
      showWhitespace.enable = true;
      numberLines = {
        enable = true;
        highlightCursor = true;
        relative = true;
        scrollOff.lines = 3;
      };
      
      wrapLines = {
        enable = true;
        indent = true;
        marker = "⏎";
      };
    };

    plugins = with pkgs.kakounePlugins; [
      fzf-kak
      kakoune-rainbow
      kakoune-buffers
      auto-pairs-kak
    ];
  };
}
