_:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      background-opacity = 0.8;
      background-blur-radius = 29;

      # because fuck blinking bars. they are obnoxious
      shell-integration-features = "no-cursor";

      font-family = "Lilex Nerd Font Mono"; 
      font-variation = "wght=100";
      font-size = "16";
      font-feature = [ "cv08" "cv09" "cv10" ];
      font-thicken = false;

      cursor-style = "block";
      cursor-style-blink = false;

      # theme = "tokyonight-storm";
      theme = "sapporo-night";

      macos-option-as-alt = true;
      macos-non-native-fullscreen = true;

      window-theme = "dark";
      window-decoration = false;
    };
  };
}
