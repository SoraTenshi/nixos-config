{ ... }:
{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # opens iTerm2
      alt - return : ~/Applications/Home\ Manager\ Apps/kitty.app

      # Navigation
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east

      # Moving windows
      shift + alt - h : yabai -m window --warp west
      shift + alt - j : yabai -m window --warp south
      shift + alt - k : yabai -m window --warp north
      shift + alt - l : yabai -m window --warp east

      # Change spaces
      alt - 1 : yabai -m space --focus 1
      alt - 2 : yabai -m space --focus 2
      alt - 3 : yabai -m space --focus 3
      alt - 4 : yabai -m space --focus 4
      alt - 5 : yabai -m space --focus 5
      alt - 6 : yabai -m space --focus 6
      alt - 7 : yabai -m space --focus 7
      alt - 8 : yabai -m space --focus 8

      # Move focus container to workspace
      shift + alt - 1 : yabai -m window --space 1; yabai -m space --focus 1
      shift + alt - 2 : yabai -m window --space 2; yabai -m space --focus 2
      shift + alt - 3 : yabai -m window --space 3; yabai -m space --focus 3
      shift + alt - 4 : yabai -m window --space 4; yabai -m space --focus 4
      shift + alt - 5 : yabai -m window --space 5; yabai -m space --focus 5
      shift + alt - 6 : yabai -m window --space 6; yabai -m space --focus 6
      shift + alt - 7 : yabai -m window --space 7; yabai -m space --focus 7
      shift + alt - 8 : yabai -m window --space 8; yabai -m space --focus 8

      # Resize windows
      lctrl + alt - h : yabai -m window --resize left:-50:0; \
                        yabai -m window --resize right:-50:0
      lctrl + alt - j : yabai -m window --resize bottom:0:50; \
                        yabai -m window --resize top:0:50
      lctrl + alt - k : yabai -m window --resize top:0:-50; \
                        yabai -m window --resize bottom:0:-50
      lctrl + alt - l : yabai -m window --resize right:50:0; \
                        yabai -m window --resize left:50:0

      # Equalize size of windows
      lctrl + alt - e : yabai -m space --balance

      # Enable / Disable gaps in current workspace
      lctrl + alt - g : yabai -m space --toggle padding; yabai -m space --toggle gap

      # Rotate windows clockwise and anticlockwise
      alt - r         : yabai -m space --rotate 270
      shift + alt - r : yabai -m space --rotate 90

      # Rotate on X and Y Axis
      shift + alt - x : yabai -m space --mirror x-axis
      shift + alt - y : yabai -m space --mirror y-axis

      # Set insertion point for focused container
      shift + lctrl + alt - h : yabai -m window --insert west
      shift + lctrl + alt - j : yabai -m window --insert south
      shift + lctrl + alt - k : yabai -m window --insert north
      shift + lctrl + alt - l : yabai -m window --insert east

      # Float / Unfloat window
      shift + alt - space : \
          yabai -m window --toggle float; \
          yabai -m window --toggle border

      # Make window native fullscreen
      alt - f         : yabai -m window --toggle zoom-fullscreen
      shift + alt - f : yabai -m window --toggle native-fullscreen
'';
  };

  system.keyboard.enableKeyMapping = true;
}
