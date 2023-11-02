_:
{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    backend = "glx";

    vSync = false;
    
    opacityRules = [
      "60:class_g = 'alacritty'"
      "100:class_g = 'eww'"
    ];

    settings = {
      rounded-corners-exclude = [
        "window_type = 'dock'"
      ];

      blur-kern = "5x5box";
      blur = {
        method = "dual_kawase";
        strength = 5;
        background = false;
        background-frame = false;
        background-fixed = false;
        kern = "5x5box";
      };
      
      blur-background-exclude = [
        "class_g ?= 'eww'"
        "class_g ?= 'peek'"
      ];
    };
  };
}

