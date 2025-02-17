{ pkgs, ... }: {
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-Storm";
      package = pkgs.tokyo-night-gtk.override {
        colorVariants = [ "dark" ];
        tweakVariants = [ "storm" ]; # activate when available
      };
    };
  };
}
