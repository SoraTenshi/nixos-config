{ inputs, pkgs, lib, ... }: {
  programs.spicetify = {
    enable = true;
    wayland = true;
    experimentalFeatures = true;
    enabledExtensions = with inputs.spicetify.legacyPackages.${pkgs.stdenv.system}.extensions; [
      shuffle lastfm copyLyrics
    ];
  };
}
