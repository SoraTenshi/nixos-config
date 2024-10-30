{ pkgs, ... }: 
let
  sbcl-env = (pkgs.symlinkJoin {
      name = "sbcl-env";
      paths = with pkgs.sbclPackages; [
        # CLI Parser
        clingon

        # CLI stuff
        trivial-shell

        # Coloured output!
        cl-ansi-term

        # Strings & dependencies
        str cl-ppcre cl-ppcre-unicode cl-ppcre-template cl-unicode
        ];
      });
in
{
  home.packages = [
    sbcl-env
  ];

  home.file = {
    "common-lisp/sbcl-env".source = sbcl-env;
  };
}
