_:
{
  imports = [
    ./hyprland
    ./river
  ];
  xdg.configFile = {
    "electron-flags.conf" = {
      text = ''
        --enable-features=WaylandWindowDecorations
        --ozone-platform-hint=auto
      '';
    };
  };
}
