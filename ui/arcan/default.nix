{ pkgs, ... }:

{
  environment.systemPackages = with pkgs.arcanPackages; [
    arcan-wrapped
    durden-wrapped
    cat9-wrapped
    xarcan
  ];
}
