{ self, config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    river
    
    eww-wayland
    wofi
    
    wayland-utils
  ];

  programs.xwayland.enable = true;

  services.random-background = {
    enable = true;
    imageDirectory = "${self}/images";
    display = "fill";
    interval = "1h";
  };
}
