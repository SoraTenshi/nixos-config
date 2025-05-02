{ pkgs, ... }:
let
  schemesh = pkgs.fetchgit {
    url = "https://github.com/cosmos72/schemesh.git";
    rev = "refs/tags/v0.9.0"; # or: "refs/heads/main"
    sha256 = ""; # insert sha256 when ready
  };
in {
  environment.systemPackages = [
    # ...
    pkgs.chez
    (pkgs.callPackage schemesh {})
  ];
}
