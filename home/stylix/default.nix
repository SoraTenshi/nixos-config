{ pkgs, ... }: 
let
  cursorPackage = pkgs.catppuccin-cursors.macchiatoBlue;
  cursorName = "Catppuccin-Macchiato-Blue-Cursors";
in
{
  stylix = {
    enable = true;
    autoEnable = true;
    cursor = {
      package = cursorPackage;
      name = cursorName;
    };
    targets = {
      fzf.enable = false;
      bat.enable = true;
      gtk.enable = false;
      helix.enable = false;
      vim.enable = false;
      kitty.enable = false;
      k9s.enable = false;
      ghostty.enable = false;
    };
  };
}
