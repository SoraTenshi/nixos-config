{ pkgs, ... }: {
  qt = {
    enable = true;
    style = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyo-night-gtk;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark";
      package = pkgs.tokyo-night-gtk;
    };
  };
}
