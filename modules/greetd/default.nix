{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.greetd.tuigreet
  ];

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland --time --asterisks";
    };
    vt = 7;
  };
}
