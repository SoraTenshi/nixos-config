{
  self,
  pkgs,
  ...
}: let
  cursorPackage = pkgs.catppuccin-cursors.macchiatoBlue;
  cursorName = "Catppuccin-Macchiato-Blue-Cursors";
in {
  imports = [
    ./picom.nix
    ../eww
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Tokyonight-Storm-BL";
      package = pkgs.tokyo-night-gtk;
    };

    cursorTheme = {
      package = cursorPackage;
      name = cursorName;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  services.random-background = {
    enable = true;
    imageDirectory = "${self}/images";
    display = "fill";
    interval = "1h";
  };

  # home = {
  #   packages = with pkgs; [
  #     # App starter
  #     rofi
  #     rofi-power-menu
  #     rofi-pulse-select
  #     rofi-file-browser

  #     dmenu
  #     networkmanager_dmenu

  #     flameshot
  #   ];
  #   file.".xsession" = {
  #     text = ''
  #       GTK_IM_MODULE=fcitx
  #       QT_IM_MODULE=fcitx
  #       XMODIFIERS=@im=fcitx
  #     '';
  #   };
  # };
}
