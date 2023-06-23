{ ... }:
{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
    };
    brews = [
      "skhd"
      "yabai"
    ];
    casks = [
      "aldente"
      "bartender"

      "ubersicht"
    ];
    taps = [
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/core"
      "homebrew/services"
    ];
  };
}
