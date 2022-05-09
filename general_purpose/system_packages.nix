{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # GTK 
    gtk3.dev gtk4.dev

    # Requried for SDDM
    libsForQt5.full

    # Required for flake updates
    git
  ];

}
