{ lib
, stdenvNoCC
, tokyo-night-gtk
, gnome-themes-extra
, gtk-engine-murrine
}:

stdenvNoCC.mkDerivation {
  pname = "tokyo-night-gtk";
  version = "unstable-2023-02-04";

  src = tokyo-night-gtk;

  propagatedUserEnvPkgs = [
    gtk-engine-murrine
  ];

  buildInputs = [
    gnome-themes-extra
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes
    cp -a themes/* $out/share/themes
    runHook postInstall
  '';

  meta = with lib; {
    description = "A GTK theme based on the Tokyo Night colour palette.";
    homepage = "www.pling.com/p/1681315/";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
    maintainers = [ maintainer.soratenshi ];
  };
}