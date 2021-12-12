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
  ];

  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    shadow = true;
    shadowOpacity = "0.5";
  };

  # leftwm kinda takes cares of the polybar :)
  home.file = {
    ".config/leftwm" = {
      source = let
        repo = pkgs.fetchFromGitHub {
          owner  =  "s0la1337";
          repo   =  "dotfiles";
          rev    =  "81dfe16c977ed296b8466e7e528281ff33aaa464";
          sha256 =  "145538jm473ygm5paxmikzs1z98qj4lswm6iild8cpv0w31lk55h";
        };
      in "${repo}/leftwm/";
    };
  };
}
