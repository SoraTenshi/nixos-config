{ pkgs, ... }: {
  home.packages = with pkgs.sbclPackages; [
    # CLI Parser
    clingon

    # Coloured output!
    cl-ansi-term
  ];
}
