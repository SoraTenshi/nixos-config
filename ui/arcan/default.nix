{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.arcanPackages; [
    arcan
    durden
    cat9
    xarcan
  ];
}
