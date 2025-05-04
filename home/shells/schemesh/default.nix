{ pkgs, ... }:
let
  schemesh = pkgs.fetchgit {
    url = "https://github.com/cosmos72/schemesh.git";
    rev = "refs/tags/v0.9.0";
    sha256 = "sha256-rNmNpUXsOAsJwSBwmS6XCOMQ4+7lilkteJ8Or9bd+zc=";
  };
in {
  home.packages = [
    pkgs.chez
    (pkgs.callPackage schemesh {})
  ];
}
