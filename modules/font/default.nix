{ pkgs, config, ... }:
let
  fontList = [
    # pkgs.rictydiminished-with-firacode
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.wqy_zenhei
    pkgs.noto-fonts-emoji-blob-bin
    pkgs.lilex
    pkgs.nerd-fonts.lilex
    pkgs.weather-icons
    (pkgs.iosevka.override {
      set = "Custom";
      privateBuildPlan = ''
        [buildPlans.IosevkaCustom]
        family = "Iosevka Custom"
        spacing = "term"
        serifs = "sans"
        noCvSs = false
        exportGlyphNames = true
        noLigation = true

        [buildPlans.IosevkaCustom.variants]
        inherits = "ss15"

        [buildPlans.IosevkaCustom.variants.design]
        one = "base"
        zero = "tall-slashed"
        lower-lambda = "tailed-turn"
        tilde = "low"
        asterisk = "turn-penta-low"
        caret = "low"
        brace = "curly-flat-boundary"
        number-sign = "slanted-open"
        at = "fourfold"
        dollar = "slanted-through"
        bar = "natural-slope"
        question = "smooth"

        [buildPlans.IosevkaCustom.weights.Regular]
        shape = 400
        menu = 400
        css = 400

        [buildPlans.IosevkaCustom.weights.Bold]
        shape = 700
        menu = 700
        css = 700
      '';
    })
  ];
  setupFonts = system:
    if system != "aarch64-darwin" then {
      fonts = { packages = fontList; };
    } else {
      fonts = { fonts = fontList; };
    };

in {
  fonts = (setupFonts config.system).fonts;

  environment.systemPackages = [ pkgs.adwaita-icon-theme ];
}
