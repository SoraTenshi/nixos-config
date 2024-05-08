_: {
  imports = [ ./hyprland ./river ];

  environment.variables = { WEBKIT_DISABLE_COMPOSITING_MODE = 1; };

  xdg.configFile = {
    "electron-flags.conf" = {
      text = ''
        --enable-features=WaylandWindowDecorations
        --ozone-platform-hint=auto
      '';
    };
  };
}
