{pkgs, ...}: {
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

  services.xserver = {
    enable = true;
    xkb = {
      layout = "eu";
      options = "compose:ralt";
    };
  };

  i18n = {
    defaultLocale = "en_US.utf8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };
}
