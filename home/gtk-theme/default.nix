{ pkgs, ... }:
let
  cursorPackage = pkgs.catppuccin-cursors.macchiatoLavender;
  cursorName = "catppuccin-macchiato-lavender-cursors";
  cursorSize = 32;
in
{
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-Storm";
      package = pkgs.tokyo-night-gtk.override {
        colorVariants = [ "dark" ];
        tweakVariants = [ "storm" ];
      };
    };
  };

  home.pointerCursor = {
    enable = true;
    name = cursorName;
    size = cursorSize;
    package = cursorPackage;
    gtk.enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = cursorSize;
    x11.enable = true;
  };
}
