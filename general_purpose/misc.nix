{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    xclip
  ];
}
