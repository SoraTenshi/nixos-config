{ inputs, pkgs, lib, ... }: {
  programs.spicetify = {
    enable = true;
    colorScheme = lib.mkForce "Storm";
    wayland = true;
    experimentalFeatures = true;
    theme = {
      name = lib.mkForce "Tokyo";
      src = pkgs.fetchFromGitHub {
        owner = "evening-hs";
        repo = "Spotify-Tokyo-Night-Theme";
        rev = "main";
        hash = "sha256-cLj9v8qtHsdV9FfzV2Qf4pWO8AOBXu51U/lUMvdEXAk=";
      };

      injectCss = true;
      injectThemeJs = true;
      replaceColors = true;
      sidebarConfig = true;
      homeConfig = true;
      overwriteAssets = false;
    };
    enabledExtensions = with inputs.spicetify.legacyPackages.${pkgs.stdenv.system}.extensions; [
      shuffle lastfm copyLyrics
    ];
  };
}
