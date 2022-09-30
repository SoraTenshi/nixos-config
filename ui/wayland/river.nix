{ config, lib, pkgs, ...}:
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

    # Cross compatibility
    xwayland
  ];
}
