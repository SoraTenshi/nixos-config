{ pkgs, ... }:
let 
  font-size = if pkgs.stdenvNoCC.isDarwin then 24 else 18;
in
{
  stylix = {
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-terminal-storm.yaml";
    image = ../../images/background0.jpg;
    opacity = {
      terminal = 0.9;
      popups = 0.8;
    };

    cursor = {
      name = "Catppuccin-Macchiato-Blue-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoBlue;
    };

    targets = {
      grub.enable = false;
    };

    fonts = {
      serif = {
        package = pkgs.nerdfonts.override { fonts = [ "Lilex" ]; };
        name = "Lilex Nerd Font";
      };

      sansSerif = {
        package = pkgs.nerdfonts.override { fonts = [ "Lilex" ]; };
        name = "Lilex Nerd Font";
      };

      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "Lilex" ]; };
        name = "Lilex Nerd Font Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes.terminal = font-size;
    };
  };
}
