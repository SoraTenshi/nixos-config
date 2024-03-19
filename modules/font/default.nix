{ pkgs, ... }: 
# let
#   material-symbols = pkgs.callPackage ../../derivations/material-symbols {};
# in
{
  environment.systemPackages = [ pkgs.gnome.adwaita-icon-theme ];
  fonts.fontDir.enable = true;
  fonts.packages = [
    # material-symbols
    pkgs.material-symbols
    pkgs.rictydiminished-with-firacode
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk
    pkgs.noto-fonts-emoji
    (pkgs.nerdfonts.override { fonts = [ "Lilex" ]; })
  ];
}
