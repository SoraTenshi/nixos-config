{ pkgs, ... }: {
  environment.systemPackages = [
    # Arcan
    pkgs.arcan pkgs.xarcan

    # Arcan WM
    pkgs.durden

    # Cat9 / Shell / LASH
    pkgs.cat9
  ];
}
