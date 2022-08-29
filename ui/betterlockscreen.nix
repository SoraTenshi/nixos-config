{ pkgs, ... }:
{
  services.betterlockscreen = {
    enable = true;
    arguments = [ "--blur 0.5" ];
    inactiveInterval = 10;
  };
}
