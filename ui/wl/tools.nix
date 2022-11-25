{ self, config, pkgs, ... }:

{
  imports = [
    ../x11/eww.nix
  ];

  services.random-background = {
    enable = true;
    imageDirectory = "${self}/images";
    display = "fill";
    interval = "1h";
  };

  home.packages = with pkgs; [
    wlr-randr
  ];
  
  xdg.configFile."river/init" = {
    executable = true;
    source = "${self}/ui/wl/river/init";
  };
}