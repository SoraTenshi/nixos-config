{ pkgs, ... }:
{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    experimentalBackends = true;

    settings = {
      corner-radius = 10.0;
      rounded-corners-exclude = [ "class_g = 'eww'" ];

      blur-kern = "3x3box";
      blur = {
        method = "kawase";
        strength = 8;
        background = true;
        background-frame = false;
        background-fixed = false;
        kern = "3x3box";
      };
      
      blur-background-exclude = [
        "class_g = 'eww'"
      ];
    };
  };
}

