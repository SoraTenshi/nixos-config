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

    # required for cl-lsp
    qlot
    qlot-cli
  ]);
in
{
  home.packages = [
    pkgs.roswell pkgs.asdf

    sbcl'
  ];
}
