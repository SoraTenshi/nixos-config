{ pkgs, config, ... }:
let
  fontList = [
    pkgs.rictydiminished-with-firacode
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-emoji-blob-bin
    (pkgs.nerdfonts.override { fonts = [ "Lilex" ]; })
  ];
  setupFonts = system:
    if system != "aarch64-darwin" then {
      fonts = { packages = fontList; };
    } else {
      fonts = { fonts = fontList; };
    };

in {
  fonts = (setupFonts config.system).fonts // { fontDir.enable = true; };

  environment.systemPackages = [ pkgs.adwaita-icon-theme ];
}
