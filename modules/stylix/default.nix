{ pkgs, ... }: {
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
    image = ../../images/background0.jpg;
    opacity = {
      terminal = 0.9;
      popups = 0.8;
    };

    targets = {
      plymouth.enable = false;
      grub.enable = false;
    };
  };
}
