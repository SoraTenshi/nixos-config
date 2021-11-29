# Used for the configuration of specific configurations

{ config, pkgs, ... }:

{
  # Enable the usage of home-manager
  # The point of home-manager is to create
  # symlinks from /nix/store
  program.home-manager.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.defaultSession = "none+leftwm";
    windowManager.leftwm.enable = true; 
    windowManager.leftwm.startup = [
      { command = "systemctl --user restart polybar"; always = true; notification = false; }
    ];
  };

  services.polybar.enable = true;

  home.packages = with pkgs; [
    # App starter
    rofi 

    # Window Manager
    # in the future probably penrose
    leftwm

    # Panel
    polybar
  ];


}
