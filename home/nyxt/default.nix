{ pkgs, ...}:

{
  home.packages = with pkgs; [
    nyxt
  ];

  # God, there should be a flake :prayge:
  xdg.configFile = {
    "nyxt/config.lisp" = {
      text = ''
        (define-configuration nyxt::buffer
          ((default-modes `(,@(get-default 'default-modes)
                            vi-normal-mode))))

        (load "keybinding.lisp")
      '';
    };

    "nyxt/keybinding.lisp" = {
      text = ''
        (define-configuration
          ((nyxt::default-modes `(,@(nyxt::default-modes)
                                (nyxt::vi-normal-mode
                                 :bindings
                                 (nyxt::make-keymap
                                  :inherit (nyxt::scheme-mode-map
                                            nyxt::vi-normal-mode-map
                                  
                                  "gn" 'buffer-next
                                  )))))))
      '';
    };
  };
}
