_:
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      background-opacity = 0.8;
      background-blur = true;

      # because fuck blinking bars. they are obnoxious
      shell-integration-features = "no-cursor";

      font-family = "Lilex Nerd Font Mono"; 
      font-variation = "wght=100";
      font-size = "14";
      font-feature = [ "cv08" "cv09" "cv10" ];
      font-thicken = false;

      cursor-style = "block";
      cursor-style-blink = false;

      quick-terminal-position = "top";
      quick-terminal-screen = "mouse";
      quick-terminal-autohide = true;
      gtk-quick-terminal-layer = "overlay";
      gtk-quick-terminal-namespace = "ghostty-quick";

      # theme = "tokyonight-storm";
      # theme = "sapporo-night";

      macos-option-as-alt = true;
      macos-non-native-fullscreen = true;

      window-theme = "dark";
      window-decoration = false;

      keybind = [
        "global:super+shift+;=toggle_quick_terminal"
      ];
    };
  };
}
