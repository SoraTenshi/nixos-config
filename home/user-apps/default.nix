{ inputs, pkgs, system, ... }:  {
  home.packages = with pkgs; [
    steam

    discord

    firefox
    mumble
    zathura
    spacedrive
    nheko
    inputs.zen-browser.packages."${system}".default
  ];
}
