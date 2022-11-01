{ self, config, pkgs, ... }:
{
  imports = [
    ./picom.nix
    ./eww.nix
    ./betterlockscreen.nix
  ];

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
    x11.defaultCursor = "Bibata-Modern-Classic";
  };

  home.packages = with pkgs; [
    # App starter
    rofi
    rofi-power-menu
    rofi-pulse-select
    rofi-file-browser

    # Window Manager
    # Highly volatile
    dmenu
    networkmanager_dmenu
  ];

  services.random-background = {
    enable = true;
    imageDirectory = "${self}/images";
    display = "fill";
    interval = "1h";
  };

  home.file.".xsession" = {
    text = ''
      GTK_IM_MODULE=fcitx
      QT_IM_MODULE=fcitx
      XMODIFIERS=@im=fcitx
    '';
  };
  
  xdg.configFile."rofi/config.rasi".text = ''
    /*
      Credits: https://github.com/Murzchnvok/rofi-collection
     */
    /*
     * ROFI color theme
     *
     * Based on Something Found in the Internet
     *
     * User: Contributors
     * Copyright: *!
     */

    configuration {
      font: "Lilex Light Nerd Font Complete Mono 11";

      drun {
        display-name: "";
      }

      run {
        display-name: "";
      }

      window {
        display-name: "";
      }

      timeout {
        delay: 10;
        action: "kb-cancel";
      }
    }

    * {
      border: 0;
      margin: 0;
      padding: 0;
      spacing: 0;

      bg: #24283b;
      bg-alt: #1a1b26;
      fg: #6a6f87;
      fg-alt: #a9b1d6;

      background-color: @bg;
      text-color: @fg;
    }

    window {
      transparency: "real";
      width: 700px;
    }

    mainbox {
      children: [inputbar, listview];
    }

    inputbar {
      background-color: @bg-alt;
      children: [prompt, entry];
    }

    entry {
      background-color: inherit;
      padding: 12px 3px;
    }

    prompt {
      background-color: inherit;
      padding: 12px;
    }

    listview {
      lines: 8;
    }

    element {
      children: [element-icon, element-text];
    }

    element-icon {
      padding: 10px 10px;
      size: 20px;
    }

    element-text {
      padding: 10px 0;
    }

    element-text selected {
      text-color: @fg-alt;
    }
  '';
}
