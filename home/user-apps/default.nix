{ pkgs, ... }: {
  programs.nheko.enable = true;
  home.packages = with pkgs; [
    steam

    discord

    qmk
    vial

    firefox
    mumble
    zathura
    spacedrive
  ];
}
