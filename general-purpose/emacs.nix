{ self, pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit-nox;

  };
}
