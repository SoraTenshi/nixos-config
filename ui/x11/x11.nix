# Used for the configuration of specific configurations

{ config, pkgs, dotfiles, ... }:

{
  imports = [
    ./picom.nix
  ];

  home.packages = with pkgs; [
    # App starter
    rofi rofi-power-menu rofi-pulse-select rofi-file-browser

    # Window Manager
    # Highly volatile
    leftwm
    dmenu networkmanager_dmenu

    # Panel
    # Maybe also volatile?
    polybar

    # Images
    nitrogen
  ];

  # leftwm kinda takes cares of the polybar :)
  home.file = {
    ".config/leftwm" = {
      source = "${dotfiles}/leftwm";
    };

    ".config/rofi" = {
      source = "${dotfiles}/rofi";
    };
  };
}
