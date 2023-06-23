{ inputs, lib, pkgs, ... }:
{
  services.nix-daemon.enable = true;
  nix = {
    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
    ];

    registry.nixpkgs.flake = inputs.nixpkgs;
    package = pkgs.nixFlakes;
    settings.auto-optimise-store = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '' ++ lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
   };

  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];
}
