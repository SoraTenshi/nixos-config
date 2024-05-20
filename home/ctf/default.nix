{pkgs, ...}:
{
  home.packages = [
    # Write custom derivation for that.
    pkgs.patchelf
    # pkgs.pwninit
    # hmm
    pkgs.gef
  ];
}
