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
      "datweatherdoe"
      "utm"
      "linearmouse"
      "bartender"
      "ubersicht"
      "keycastr"
      "raycast"
      "spotify"
      "stats"
      # for YabaiIndicator, use the default installation..
    ];
  };
}
