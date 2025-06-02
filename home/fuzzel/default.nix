{ pkgs, ... }: {
  home.packages = [
    pkgs.shutdown-script-ros
  ];

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.ghostty}/bin/ghostty";
        layer = "overlay";
      };
    };
  };
}
