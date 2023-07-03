{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fcitx5-configtool openal harfbuzz libxkbcommon
  ];

  time = {
    timeZone = "Europe/Berlin";
    hardwareClockInLocalTime = true;
  };

  services.xserver = {
    enable = true;
    layout = "eu";
  };

  i18n = {
    defaultLocale = "ja_JP.utf8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };
}
