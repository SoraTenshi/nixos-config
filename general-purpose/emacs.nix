{ pkgs, nix-doom-emacs, ... }:
{
  programs.emacs.enable = true;
  # home = lib.mkMerge [
  #   nix-doom-emacs.hmModule { ... }: {
  #     programs.doom-emacs = {
  #       enable = true;
  #       doomPrivateDir = ./doom.d;
  #     };
  #   }
  # ];
}
