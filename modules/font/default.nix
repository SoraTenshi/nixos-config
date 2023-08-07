{ pkgs, ... }: 
{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    material-symbols
    meslo-lgs-nf
    rictydiminished-with-firacode
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "Lilex" ]; })
  ];
}
