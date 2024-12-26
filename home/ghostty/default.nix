{ inputs, system, ... }:
{
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty-package.${system}.default;
    shellIntegration = {
      enable = true;
      enableZshIntegration = true;
    };

    settings = {
      background-opacity = 0.8;
      background-blur-radius = 29;

      font-family = "Lilex Nerd Font Mono"; 
      font-variation = "wght=100";
      font-size = "24";
      font-features = [ "cv08" "cv09" "cv10" ];
      font-thicken = false;

      cursor-color = "c0caf5";
      cursor-style = "block";
      cursor-style-blink = false;

      theme = "tokyonight-storm";

      macos-option-as-alt = true;
      macos-non-native-fullscreen = true;

      window-theme = "dark";
      window-decoration = false;
      
    };
  };
}
