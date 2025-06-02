{ stdenv, roswell, sbcl, fuzzel }:
  stdenv.mkDerivation {
  pname = "shutdown-menu";
  version = "0.1";

  src = ../../scripts/shutdown.ros;

  buildInputs = [
    roswell
    sbcl
    fuzzel
  ];

  unpackPhase = ''
    cp $src shutdown.ros
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp shutdown.ros $out/bin/shutdown-menu
    chmod +x $out/bin/shutdown-menu
  '';
}
