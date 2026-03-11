{ pkgs, ... }: {
  home.packages = with pkgs; [
    fuzzel

    # screenshot stuff
    grim
    slurp

    wayshot
    waylock
    wlr-randr
    wofi
  ];

  xdg.configFile = {
    "river/init" = {
      executable = true;
      source = ./init;
    };
    "electron-flags.conf" = {
      text = ''
        --enable-features=WaylandWindowDecorations
        --ozone-platform-hint=auto
      '';
    };
    # TODO: Migrate to base16 & nix-colors
    "fuzzel/fuzzel.ini" = {
      text = ''
        font='Lilex Nerd Font Mono-16'
        prompt='->'

        [dmenu]
        mode=text

        [colors]
        background=24283bff
        text=a9b1d6ff
        match=8031caff
        selection=8031caff
        selection-text=7aa2f7ff
        selection-match=2ac3deff
        border=8031caff

        [border]
        width=2
        radius=0
      '';
    };
  };
}
