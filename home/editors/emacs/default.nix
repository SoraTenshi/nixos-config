{ pkgs, ... }: {
  services.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    defaultEditor = true;
    startWithUserSession = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
  };
}
