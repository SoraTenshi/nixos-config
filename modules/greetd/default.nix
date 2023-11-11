{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.greetd.tuigreet
  ];

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet} --cmd Hyprland";
    };
    vt = 7;
  };
}
