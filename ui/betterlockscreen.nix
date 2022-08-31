{ pkgs, ... }:
{
  services.betterlockscreen = {
    enable = true;
    arguments = [ "--blur 0.5" "-l" "--dim 60" ];
    inactiveInterval = 10;
  };
}
