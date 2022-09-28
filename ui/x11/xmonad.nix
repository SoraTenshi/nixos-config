{ config, pkgs, dotfiles, ... }:
{
  imports = [
    ./picom.nix
    ./eww.nix
    ../betterlockscreen.nix
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  home.packages = with pkgs; [
    # App starter
    rofi
    rofi-power-menu
    rofi-pulse-select
    rofi-file-browser

    # Window Manager
    # Highly volatile
    dmenu
    networkmanager_dmenu
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
    ".xsession" = {
      text = ''
        GTK_IM_MODULE=fcitx
        QT_IM_MODULE=fcitx
        XMODIFIERS=@im=fcitx
      '';
    };
  };
}
