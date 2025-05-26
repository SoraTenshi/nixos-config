{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    fcitx5-configtool
    openal
    harfbuzz
    libxkbcommon
  ];

  time = {
    timeZone = "Europe/Berlin";
    hardwareClockInLocalTime = true;
  };

  # services.xserver = {
  #   enable = true;
  #   xkb = {
  #     layout = "eu";
  #     options = "compose:ralt";
  #   };
  # };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-rose-pine
        fcitx5-configtool
        # fcitx5-skk
      ];
    };
  };
}
