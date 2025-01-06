_: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    casks = [
      "bitwarden"
      "docker"
      "keycastr"
      "linearmouse"
      "raycast"
      "spotify"
      "ubersicht"
      "utm"
    ];
  };
}
