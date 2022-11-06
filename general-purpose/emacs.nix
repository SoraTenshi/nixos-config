{ self, pkgs, ... }:
{
  # Necessary plugins:
  # - meow-edit
  # - zig-mode
  # - tokyo-night-storm
  # - rainbow indentation guides (need to be figured out)
  # - rainbow brackets
  programs.emacs = {
    enable = true;
    package = pkgs.emacsGit-nox;

  };
}
