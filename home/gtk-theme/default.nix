{ pkgs, ... }: {
  qt = {
    enable = true;
    style = {
      name = "Tokyonight-Storm-BL";
      package = pkgs.tokyo-night-gtk;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Storm-BL";
      package = pkgs.tokyo-night-gtk;
    };
  };
}
