{ inputs, pkgs, system, useChromium, ... }:  {
  home.packages = with pkgs; [
    discord-canary

    firefox
    mumble
    zathura
    spacedrive
    nheko
    mpv
    inputs.zen-browser.packages."${system}".default

    bitwarden-desktop
  ] ++ (if useChromium then [brave vivaldi microsoft-edge eww] else []);
}
