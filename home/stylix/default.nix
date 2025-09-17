{ pkgs, tokyo-night, ... }:
let
  sapporo-night = {
    base00 = "202037";
    base01 = "2a2947";
    base02 = "33325d";
    base03 = "4a5073";
    base04 = "565f89";
    base05 = "a0b7eb";
    base06 = "8bbaf3";
    base07 = "b0d4ff";
    base08 = "c678dd";
    base09 = "a9c7ff";
    base0A = "9dc8f8";
    base0B = "b0d4ff";
    base0C = "56d8f4";
    base0D = "9ab1fa";
    base0E = "ab8bf7";
    base0F = "94b5f0";
  };
in
let
  stylix-color = (if tokyo-night then "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml" else sapporo-night);
  cursorPackage = pkgs.catppuccin-cursors.macchiatoLavender;
  cursorName = "catppuccin-macchiato-lavender-cursors";
  cursorSize = 32;
in {
  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = stylix-color;
    cursor = {
      name = cursorName;
      package = cursorPackage;
      size = cursorSize;
    };
    targets = {
      gtk.enable = false;
      fzf.enable = (!tokyo-night);
      helix.enable = false;
      emacs.enable = false;
      kitty.enable = false;
      ghostty.enable = false;
    };
  };
}
