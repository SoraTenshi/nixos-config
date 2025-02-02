{ pkgs, ... }:
{
  home.packages = [
    pkgs.R
    pkgs.rPackages.ggplot2
    pkgs.rPackages.dplyr
  ];
}
{ pkgs, ... }:
{
  home.packages = [
    pkgs.R
    pkgs.rPackages.languageserver
    pkgs.rPackages.ggplot2
    pkgs.rPackages.dplyr
  ];
}
