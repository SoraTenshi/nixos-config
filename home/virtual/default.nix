{ pkgs, ... }:
{
  home.packages = [
    pkgs.virt-manager
    pkgs.mtr
    pkgs.partition-manager
  ];
}
