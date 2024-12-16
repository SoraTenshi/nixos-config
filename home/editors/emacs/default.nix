_: {
  # Necessary plugins:
  # - zig-mode
  # - rainbow indentation guides (need to be figured out)
  programs.emacs = {
    enable = true;

    init = {
      enable = true;
      recommendedGcSettings = true;

      prelude = ''
        (whitespace-mode)
        (setq display-line-numbers-type 'relative)
        (global-display-line-numbers-mode t)
        (tool-bar-mode -1)
        (menu-bar-mode -1)
        (set-fringe-mode 0)
        (scroll-bar-mode -1)

        (set-face-attribute 'default nil
          :family "Lilex Nerd Font Mono"
  		    :height 140)
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

        rainbow-mode = {
          enable = true;
          hook = [ "(prog-mode . rainbow-mode)" ];
        };

        which-key = {
          enable = true;
          diminish = [ "which-key-mode" ];
          config = "(which-key-mode)";
        };

        evil = {
          enable = true;
          config = "(evil-mode 1)";
        };

        doom-themes = {
          enable = true;
          config = ''
          (setq doom-themes-enable-bold t
                doom-themes-enable-italic t)
          (load-theme 'doom-moonlight t)
          '';
        };

        flycheck = {
          enable = true;
          init = "(global-flycheck-mode)";
        };

        nyan-mode = {
          enable = true;
          config = ''
            (nyan-mode)
            (nyan-start-animation)
          '';
          extraConfig = ":if window-system";
        };

        projectile = {
          enable = true;
          config = ''
          (projectile-mode)
          (setq projectile-completion-system 'auto)
          '';
          diminish = [ "projectile" ];
        };

        all-the-icons = {
          enable = true;
        };

        fancy-compilation = {
          enable = true;
          config = ''
            (fancy-compilation-mode)
          '';
        };

        elcord = {
          enable = true;
          hook = [ "(prog-mode . elcord-mode)" ];
        };

        smudge = {
          enable = true;
          config = ''
            (setq smudge-transport 'connect)
          '';
        };

        centaur-tabs = {
          enable = true;
          config = ''
          (setq centaur-tabs-style "chamfer"
                centaur-tabs-set-icons t
                centaur-tabs-set-bar 'under
                centaur-tabs-set-modified-marker t
                centaur-tabs-modified-marker "*"
                centaur-tabs-cycle-scope 'tabs
                centaur-tabs-icon-type 'all-the-icons
                centaur-tabs-close-button "x"
              	x-underline-at-descent-line t
              	centaur-tabs-left-edge-margin nil)
          (centaur-tabs-change-fonts (face-attribute 'default :font) 110)
          (centaur-tabs-headline-match)
          (centaur-tabs-mode t)
          '';
        };

        cc-mode = {
          enable = true;
          config = ''
          (setq c-default-style "k&r"
                c++-default-style "stroustrup"
                c-basic-offset 2)
          '';
        };

        sly = {
          enable = true;
          config = ''
          (setq inferior-lisp-program "sbcl")
          '';
        };

        rust-mode = {
          enable = true;
          hook = [ "(rust-mode . subword-mode)" ];
        };

        zig-mode = {
          enable = true;
          hook = [ "(zig-mode . subword-mode)" ];
        };

        nix-mode = {
          enable = true;
          hook = [ "(nix-mode . subword-mode)" ];
        };

        treesit-auto = {
          enable = true;
          config = "(treesit-auto-add-to-auto-mode-alist 'all)";
        };
      };
    };
  };
}
