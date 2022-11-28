{ self, config, pkgs, ... }:

{
  imports = [
    ../x11/eww.nix
  ];

  home.packages = with pkgs; [
    wlr-randr
  ];
  
  xdg.configFile."river/init" = {
    executable = true;
    source = "${self}/ui/wl/river/init";
  };
}