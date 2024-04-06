{pkgs, ...}: {
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        language = "en"; # i often use JP locale, but yeah, i am not yet fully able to read most kanji :')
        nerdFontsVersion = "3";
        border =
          if pkgs.stdenvNoCC.isDarwin
          then "rounded"
          else "single";
        showBottomLine = false;
      };
    };
  };
}
