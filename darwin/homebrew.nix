_:
{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [
    ];

    brews = [
      "docker-machine"
      "docker-compose"
      "qemu"
      "podman"
    ];

    casks = [
      "datweatherdoe"
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
