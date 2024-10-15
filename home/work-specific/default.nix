{ pkgs, ... }: {
  imports = [ ../obs ];

  home.packages = [
    pkgs.thunderbird
    pkgs.mumble
    pkgs.zathura
    pkgs.keepassxc
    pkgs.dino
  ];
}
