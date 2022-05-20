{ pkgs, nix-doom-emacs, ... }:
{
  home = lib.mkMerge [
    nix-doom-emacs.hmModule { ... }: {
      programs.doom-emacs = {
        enable = true;
        doomPrivateDir = ./doom.d;
      };
    }
  ];
}
