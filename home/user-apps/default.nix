{ pkgs, ... }: {
  home.packages = with pkgs; [
    steam

    discord

    firefox
    mumble
    zathura
    spacedrive
    cinny-desktop nheko
  ];
}
