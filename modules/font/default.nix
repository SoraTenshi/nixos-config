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
