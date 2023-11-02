{ pkgs, ... }:
{

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-backgroundremoval
    ];
  };

  home.packages = [
    pkgs.thunderbird
    pkgs.mumble
    pkgs.zanthura
    pkgs.keepassxc
  ];
}
