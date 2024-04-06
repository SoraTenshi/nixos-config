{pkgs, ...}: {
  home.packages = with pkgs; [
    nyxt
  ];

  # God, there should be a flake :prayge:
  xdg.configFile = {
    "nyxt/config.lisp" = {
      text = ''
        (in-package #:nyxt-user)
        (define-configuration nyxt::buffer
          ((default-modes `(,@(get-default 'default-modes)
                            vi-normal-mode))))

        (nyxt::load-file "theme.lisp")
        (nyxt::load-file "keybinding.lisp")
      '';
    };

    "nyxt/theme.lisp" = {
      text = ''
        (in-package #:nyxt-user)
        (define-configuration browser
          ((theme (make-instance 'theme:theme
                                 :dark-p t
                                 :background-color "#24283b"
                                 :on-background-color "#a9b1d6"
                                 :primary-color "#f7768e"
                                 :on-primary-color "#ff9e64"
                                 :secondary-color "#e0af68"
                                 :on-secondary-color "#9ece6a"
                                 :accent-color "#73daca"
                                 :on-accent-color "#b4f9f8"))))
        (define-configuration nyxt/style-mode:dark-mode
          ((style #.(cl-css:css
            '((*
            :background-color "#24283b !important"
            :color "#c0caf5")
            (a
            :color "#7aa2f7 !important"))))))
      '';
    };

    "nyxt/keybinding.lisp" = {
      text = ''
        (in-package #:nyxt-user)
        (define-configuration
          ((nyxt::default-modes `(,@(nyxt::default-modes)
                                (nyxt::vi-normal-mode
                                 :bindings
                                 (nyxt::make-keymap
                                  :inherit (nyxt::scheme-mode-map
                                            nyxt::vi-normal-mode-map

                                  "gn" 'buffer-next)))))))
      '';
    };
  };
}
