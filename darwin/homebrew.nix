_: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    casks = [
      "bitwarden"
      # "docker"
      "ghostty"
      "keycastr"
      "linearmouse"
      "mullvad"
      "raycast"
      "steam"
      "spotify"
      "ubersicht"
      "utm"
    ];
  };
}
