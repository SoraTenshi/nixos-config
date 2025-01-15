{ pkgs, ... }: {
  environment.systemPackages = [
    # Arcan
    pkgs.arcan #pkgs.xarcan
    pkgs.arcan-all-wrapped

    # Arcan WM
    pkgs.durden

    # Cat9 / Shell / LASH
    pkgs.cat9
  ];
}
