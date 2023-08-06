{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [
      "homebrew/cask"
    ];

    brews = [
      "docker-compose"
    ];

    casks = [
      "datweatherdoe"
      "utm"
      "linearmouse"
      "ubersicht"
      "keycastr"
      "raycast"
      "spotify"
      "stats"
      # for YabaiIndicator, use the default installation..
    ];
  };
}
