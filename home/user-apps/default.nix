{ inputs, pkgs, system, ... }:  {
  home.packages = with pkgs; [
    steam

    discord-canary

    firefox
    mumble
    zathura
    spacedrive
    nheko
    inputs.zen-browser.packages."${system}".default

    bitwarden-desktop
  ];
}
