{ pkgs, ... }:
{
  nix = {
    package = pkgs.nixUnstable;
    settings.auto-optimise-store = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];
}
