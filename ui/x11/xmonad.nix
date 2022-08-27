{ config, pkgs, dotfiles, ... }:

{
  imports = [
    ./picom.nix
    ./eww.nix
  ];
  
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
  ];
  
  services.random-background = {
    enable = true;
    imageDirectory = "${dotfiles}/images";
    display = "fill";
    interval = "1h";
  };

  home.file = {
    ".config/rofi" = {
      source = "${dotfiles}/rofi";
    };
  };
}
