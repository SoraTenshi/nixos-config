{ username, ... }: {
  imports = [ ./hyprland ./river ];

  environment.variables = { WEBKIT_DISABLE_COMPOSITING_MODE = 1; };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "com.system76.CosmicFiles.desktop";
      "x-directory/normal" = "com.system76.CosmicFiles.desktop";
    };
  };

  xdg.configFile = {
    "electron-flags.conf" = {
      text = ''
        --enable-features=WaylandWindowDecorations
        --ozone-platform-hint=auto
      '';
    };
  };
}
