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

    init = {
      enable = true;
      recommendedGcSettings = true;

      usePackage = {
        # https://github.com/Fanael/rainbow-delimiters
        rainbow-delimiters = {
          enable = true;
          # use-package also provides built-in support for the diminish and
          # delight utilities—if you have them installed. Their purpose is to
          # remove or change minor mode strings in your mode-line.
          diminish = [ "rainbow-delimiters-mode" ];
          # The :hook keyword allows adding functions onto hooks, here only the basename of the hook is required.
          hook = [ "(prog-mode . rainbow-delimiters-mode)" ];
        };

        nyan-mode = {
          enable = true;
          config = ''
            (nyan-mode)
            (nyan-start-animation)
          '';
          extraConfig = ":if window-system";
        };
      };
    };
  };
}
