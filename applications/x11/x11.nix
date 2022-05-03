# Used for the configuration of specific configurations

{ config, pkgs, dotfiles, ... }:

{
  home.packages = with pkgs; [
    # App starter
    rofi 

    # Window Manager
    # in the future probably penrose
    leftwm
    dmenu networkmanager_dmenu

    # Compositor
    picom

    # Panel
    polybar

    # Images
    feh
  ];

  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    shadow = true;
    shadowOpacity = "0.5";
    blur = true;
    extraOptions = ''
      # Corners
      corner-radius = 12.0;
      round-borders = 1;
    '';
  };

  # leftwm kinda takes cares of the polybar :)
  home.file = {
    ".config/leftwm" = {
      source = "${dotfiles}/leftwm";
    };
  };
}
