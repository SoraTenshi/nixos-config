{ inputs, pkgs, system, ... }:  {
  home.packages = with pkgs; [
    discord-canary
    mullvad

    firefox
    mumble
    zathura
    spacedrive
    nheko
    mpv
    inputs.zen-browser.packages."${system}".default

    bitwarden-desktop
  ];
}
