{ pkgs, ... }:
{
  qt = {
    enable = true;
    style = {
      name = "Tokyonight-Storm-BL";
      package = pkgs.tokyonight-gtk-theme-variants.themes.storm-bl;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Storm-BL";
      package = pkgs.tokyonight-gtk-theme-variants.themes.storm-bl;
    };
  };
}
