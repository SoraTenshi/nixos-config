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
          rev    =  "7c77f8b461cabc6a16a902571de14cde08dc9497";
          sha256 =  "07a4bzddjlc5snjv00k1avkk7imz3faxq2fcq7f8bgl3i30f29n7";
        };
      in "${repo}/leftwm/";
    };
  };
}
