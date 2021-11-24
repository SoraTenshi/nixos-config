{ config, pkgs, ... };

{
  home.username = "dreamer";
  home.homeDirectory = "/home/dreamer";
  home.stateVersion = "21.11";

  programs.home-manager.enable = true;
}
