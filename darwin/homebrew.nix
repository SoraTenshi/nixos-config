{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [
      "homebrew/cask"
    ];

    brews = [
    ];

    casks = [
      "bartender"
      "ubersicht"
      "raycast"
      "spotify"
      # for YabaiIndicator, use the default installation..
    ];
  };
}
