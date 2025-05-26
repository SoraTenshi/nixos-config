{ inputs, pkgs, ... }: {
  programs.spicetify = {
    enable = true;
    theme = {
      name = "Tokyo";
      src = pkgs.fetchFromGithub {
        owner = "evening-hs";
        repo = "Spotify-Tokyo-Night-Theme";
        rev = "main";
        hash = "0000000000000000000000000000000000000000000000000000";

        injectCss = true;
        injectThemeJs = true;
        replaceColors = true;
        homeConfig = true;
      };
    };
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system}.extensions; [
      shuffle powerBar lastfm copyLyrics
    ];
  };
}
