{ lib, stdenv, tokyo-night-gtk, ... }:

stdenv.mkDerivation
{
  inherit (tokyo-night-gtk) pname version src;

  installPhase = ''
    mkdir -p $out/share/themes/
    cp -rf themes/TokyoNight* $out/share/themes/
  '';
}
