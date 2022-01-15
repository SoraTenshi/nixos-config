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
          rev    =  "612c6047bf6a4c7df86bd347e352faa1a75bec3b";
          sha256 =  "0i8chiwak51n6gjjxy0m79lmn16nag2nf74z2dgs5qf5cms41j35";
        };
      in "${repo}/leftwm/";
    };
  };
}
