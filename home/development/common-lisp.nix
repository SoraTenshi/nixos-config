{ pkgs, ... }: 
let
  sbcl' = pkgs.sbcl.withPackages(ps: with ps; [
    # CLI Parser
    clingon

    # CLI stuff
    trivial-shell cmd

    # Coloured output!
    cl-ansi-term

    # Strings & dependencies
    str
  ]);
in
{
  home.packages = [
    pkgs.roswell pkgs.asdf

    sbcl'
  ];
}
