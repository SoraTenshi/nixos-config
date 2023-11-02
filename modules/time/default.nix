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
    xkbOptions = "compose:ralt";
  };

  i18n = {
    defaultLocale = "en_US.utf8";
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };
}
