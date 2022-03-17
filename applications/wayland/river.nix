{ config, lib, pkgs, dotfiles, ...}:
{

  home.packages = with pkgs; [
    # Compositor
    river

    # App launcher
    wofi

    # Status bar
    yambar

    # Power management panel
    wlogout

    # Lockscreen
    swaylock

    # Layout generator
    rivercarro

    # Wallpaper stuff
    oguri
  ];

  hardware.opengl.enable = true;

  programs.xwayland.enable = true;

  home.file = {
    ".config/river/init" = {
      source = "${dotfiles}/river/init";
    };
  };

}
