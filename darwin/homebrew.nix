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
      "mullvad-vpn"
      "raycast"
      "steam"
      "spotify"
      "ubersicht"
      "utm"
      {
        name = "Kegworks-App/kegworks/kegworks";
        args = { no_quarantine = true; };
      }
    ];
  };
}
