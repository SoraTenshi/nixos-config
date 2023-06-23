{ ... }:
{
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh
    '';
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = let yabai = "/opt/homebrew/bin/yabai"; in ''

    '';
  };
}
