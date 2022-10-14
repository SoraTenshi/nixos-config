{ self, pkgs, ... }:
{
  services.betterlockscreen = {
    enable = true;
    arguments = [ "-u" "${self}/images/background.png" "--blur 0.5" "-l" "--dim 60" "-w"];
    inactiveInterval = 10;
  };
}
