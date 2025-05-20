{ inputs, system, ... }:
let
  hxs = inputs.helix-steel.packages.${system}.default;
in
{
  home.packages = [ hxs ];
}
