{pkgs, ...}: {
  home.packages = with pkgs; [
    # spotify-tui
    spotify
  ];

  # services.spotifyd = {
  #   enable = true;
  #   settings = {
  #     global = {
  #       device_name = "NixOS";
  #     };
  #   };
  # };
}
