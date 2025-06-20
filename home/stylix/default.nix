{ pkgs, ... }:
let
  cursorPackage = pkgs.catppuccin-cursors.macchiatoLavender;
  cursorName = "catppuccin-macchiato-lavender-cursors";
  cursorSize = 32;
in {
  stylix = {
    enable = true;
    autoEnable = true;
    cursor = {
      name = cursorName;
      package = cursorPackage;
      size = cursorSize;
    };
    targets = {
      fzf.enable = false;
      gtk.enable = false;
      helix.enable = false;
      kitty.enable = false;
      ghostty.enable = false;
      spicetify.enable = true;
    };
  };
}
