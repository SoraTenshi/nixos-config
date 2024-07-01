{ inputs, ... }: {
  # Necessary plugins:
  # - zig-mode
  # - rainbow indentation guides (need to be figured out)
  programs.emacs = {
    enable = true;
    # package = pkgs.emacsGit-nox;

    init = {
      enable = true;
      recommendedGcSettings = true;

      prelude = ''
        (whitespace-mode)
      '';

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

        meow = {
          enable = true;
          config = builtins.readFile "${inputs.self}/home/editors/emacs/emacs/meow.el";
          extraConfig = ''
            (meow-setup)
            (meow-global-mode 1)
          '';
        };

        doom-themes = {
          enable = true;
          config =
            builtins.readFile "${inputs.self}/home/editors/emacs/emacs/tokyonight.el";
          extraConfig = ''
            (doom-tokyonight-storm)
            (load-theme 'doom-tokyo-night t)
          '';
        };

        nyan-mode = {
          enable = true;
          config = ''
            (nyan-mode)
            (nyan-start-animation)
          '';
          extraConfig = ":if window-system";
        };

        nix-mode = {
          enable = true;
          hook = [ "(nix-mode . subword-mode)" ];
        };
      };
    };
  };
}
