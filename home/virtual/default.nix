{ pkgs, ... }:
{
  home.packages = [
    pkgs.virt-manager
    pkgs.libguestfs
    pkgs.mtr
    pkgs.partition-manager
  ];
}
