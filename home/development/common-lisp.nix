{ pkgs, ... }: {
  home.packages = [
    (pkgs.symlinkJoin {
    name = "sbcl-env";
    paths = with pkgs.sbclPackages; [
      # CLI Parser
      clingon

      # CLI stuff
      trivial-shell

      # Coloured output!
      cl-ansi-term

      # Strings
      str
      ];
    })
  ];
}
