{ anyrun, config, ... }:
let
  col = sel: config.lib.stylix.colors.withHashtag.${sel};
in
{
  programs.anyrun = {
    enable = true;
    config = {
      plugins = with anyrun.packages."x86_64-linux"; [
        applications
        randr
        rink
        shell
        stdin
        symbols
        translate
      ];
      x = { fraction = 0.5; };
      y = { fraction = 0.025; };
      height = { fraction = 0.05; };
      width = { fraction = 1.0; };
      layer = "overlay";
      hidePluginInfo = true;
      maxEntries = 15;
    };

    extraCss = ''
      @define-color text ${col "base05"};
      @define-color alt-text ${col "base04"};
      @define-color bg-active ${col "base01"}99;
      @define-color bg-inactive ${col "base00"}99;
      @define-color unselected ${col "base00"}99;
      @define-color selected ${col "base03"}99;

      * {
        transition: 200ms ease;
        font-family: "Lilex Nerd Font Mono Regular";
        font-size: 1.6rem;
      }

      #main {
        background: transparent;
      }

      #plugin,
      #main {
        color: @text;
        background-color: @bg-active;
        border: 1px solid @bg-inactive;
      }

      #entry {
        color: @text;
        background-color: @bg-inactive;
      }

      #match {
        color: @text;
        background: @unselected;
      }

      #match:selected {
        color: @alt-text;
        background: @selected;
      }
    '';
  };
}
