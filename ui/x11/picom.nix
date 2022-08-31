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

      blur = {
        method = "kawase";
        strength = 5;
        background = true;
        background-frame = false;
        background-fixed = false;
        kern = "5x5box";
      };
    };
  };
}

