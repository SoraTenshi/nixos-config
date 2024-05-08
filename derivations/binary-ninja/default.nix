{ stdenv, glib, libglvnd, xlibs, fontconfig, dbus, autoPatchelfHook, }:
stdenv.mkDerivation {
  name = "binary-ninja";

  src = /home/dreamer/temp/binaryninja.zip;

  installPhase = ''
    mkdir -p $out/share/binary-ninja
    cp -r * $out/share/binary-ninja
  '';

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    stdenv.cc.cc
    glib
    fontconfig
    dbus
    libglvnd
    xlibs.libX11
    xlibs.libXi
    xlibs.libXrender
  ];
}
