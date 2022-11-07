{ pkgs, ... }:
{
  home.packages = with pkgs; [
    spotify-tui
  ];

  services.spotifyd = {
    enable = true;
    settings = {
      global = {
        device_name = "NixOS";
      };
    };
  };
}
