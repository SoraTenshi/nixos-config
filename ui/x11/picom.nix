{ pkgs, ... }:
{
  services.picom  = {
    enable        = true;
    fade          = true;
    fadeDelta     = 5;
    shadow        = false;
    settings  = ''
      # Corners
      corner-radius = 10.0;

      blur: {
        method = "dual_kawase";
        strength = 2;
        background = true;
        background-frame = false;
        background-fixed = false;
        kern = "5x5box";
      }

      blur-background = false;
      blur-background-frame = true;
      blur-background-fixed = true;
    '';
  };
}
