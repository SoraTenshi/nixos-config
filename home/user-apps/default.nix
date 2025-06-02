{ inputs, pkgs, system, useChromium, ... }:  {
  home.packages = with pkgs; [
    discord-canary

    cosmic-files

    firefox
    mumble
    zathura
    spacedrive
    nheko
    mpv
    inputs.zen-browser.packages."${system}".default

    bitwarden-desktop
  ] ++ (if useChromium then [brave] else []);
}
