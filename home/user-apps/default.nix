{ inputs, pkgs, system, ... }:  {
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
  ];
}
