{ config, pkgs, dotfiles, ... }:

{
  home.pointerCursor = {
    package = pkgs.nordzy-cursor-theme;
    name = "Nordzy-black-cursors";
    size = 32;
    x11.enable = true;
    gtk.enable = true;
  };
  
  home.packages = with pkgs; [
    # App starter
    rofi rofi-power-menu rofi-pulse-select rofi-file-browser

    # Window Manager
    # Highly volatile
    dmenu networkmanager_dmenu

    # Compositor
    picom
  ];
  
  services.random-background = {
    enable = true;
    imageDirectory = "${dotfiles}/images";
    display = "fill";
    interval = "1h";
  };

  services.picom  = {
    enable        = true;
    #fade          = true;
    #fadeDelta     = 5;
    #shadow        = false;
    #blur          = true;
    extraOptions  = ''
      # Corners
      corner-radius = 10.0;

      blur: {
        method = "dual_kawase";
        strength = 2;
        background = true;
        background-frame = false;
        background-fixed = false;
        kern = "5x5box";
      }

      blur-background = false;
      blur-background-frame = true;
      blur-background-fixed = true;
    '';
  };

  home.file = {
    ".config/rofi" = {
      source = "${dotfiles}/rofi";
    };
  };
}
