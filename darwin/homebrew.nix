{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [
      "homebrew/cask"
    ];

    brews = [
      "docker-machine"
      "docker-compose"
    ];

    casks = [
      "datweatherdoe"
      "docker"
      "keycastr"
      "linearmouse"
      "raycast"
      "spotify"
      "stats"
      "ubersicht"
      "utm"
    ];
  };
}
