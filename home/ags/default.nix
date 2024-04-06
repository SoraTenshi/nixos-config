{
  ags-env,
  pkgs,
  ...
}: {
  programs.ags = {
    enable = true;
    configDir = ags-env;
    extraPackages = [pkgs.libsoup_3];
  };
}
