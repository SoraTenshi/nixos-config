# Used for the configuration of specific configurations

{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # App starter
    rofi 

    # Window Manager
    # in the future probably penrose
    leftwm

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
      rounded-corners-exclude = [
        "class_g = 'Polybar'"
      ];
      round-borders = 1;

      active-opacity = 0.6;
    '';
  };

  # leftwm kinda takes cares of the polybar :)
  home.file = {
    ".config/leftwm" = {
      source = let
        repo = pkgs.fetchFromGitHub {
          owner  =  "s0la1337";
          repo   =  "dotfiles";
          rev    =  "a2f400f0756048c6c1e19e24bdb763986b4537a3";
          sha256 =  "02xaj99sx2skp1j7aqb7ls28alqg2y4vj3kgb8ddbjdy3hm670ql";
        };
      in "${repo}/leftwm/";
    };
  };
}
