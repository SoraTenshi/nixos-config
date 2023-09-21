{ pkgs, ... }: 
{
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    material-symbols
    rictydiminished-with-firacode
    (nerdfonts.override { fonts = [ "Lilex" ]; })
  ];
}
