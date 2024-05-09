{ ags-env, pkgs, ... }: {
  home.packages = [
    pkgs.bun # Requirement for typescript ;)
  ];

  programs.ags = {
    enable = true;
    configDir = ags-env;
    extraPackages = [ pkgs.libsoup_3 ];
  };
}
