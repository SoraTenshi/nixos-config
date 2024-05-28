{ pkgs, ... }: {
  home.packages = [
    # Gdb frontend
    pkgs.gef

    # Pwninit
    pkgs.pwninit pkgs.patchelf

    # ----- Big packages, not sure if i want to have them in my list yet ----- #
    # pkgs.python312Packages.angr pkgs.python312Packages.z3-solver

    pkgs.pwntools pkgs.python312Packages.pwntools
  ];
}
