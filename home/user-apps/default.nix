{ inputs, pkgs, system, useChromium, ... }: {
  home.packages = with pkgs; [
    cosmic-files

    firefox
    mumble
    zathura
    spacedrive
    nheko
    mpv
    inputs.zen-browser.packages."${system}".default
  ] ++ (if useChromium then [brave] else []);
}
