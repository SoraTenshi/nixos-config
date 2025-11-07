{ pkgs, lib, ... }: {
  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Dark-Storm";
      package = pkgs.tokyonight-gtk-theme.override {
        colorVariants = [ "dark" ];
        tweakVariants = [ "storm" ];
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = {
      name = lib.mkForce "gtk";
    };
  };
}
