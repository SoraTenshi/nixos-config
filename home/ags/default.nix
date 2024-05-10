{ ags-env, pkgs, ... }: {
  home.packages = [
    pkgs.bun # Requirement for typescript ;)
    pkgs.weather-icons # The weather icons for the weather display
    pkgs.material-symbols # Generalized symbols for all sorts of display ;)
  ];

  programs.ags = {
    enable = true;
    configDir = ags-env;
    extraPackages = [ pkgs.libsoup_3 ];
  };
}
