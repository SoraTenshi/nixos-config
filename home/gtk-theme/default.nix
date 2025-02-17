{ pkgs, lib, ... }: {
  qt = {
    enable = true;
    style = {
      name = lib.mkForce "Tokyonight-Dark-Storm";
      package = pkgs.tokyo-night-gtk;
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-Storm";
      package = pkgs.tokyo-night-gtk.override {
        colorVariants = [ "dark" ];
        # tweakVariants = [ "storm" ]; # activate when available
        tweakVariants = [ "storm" ];
      };
    };
  };
}
