{ pkgs, ... }:
{
  environment.systemPackages = with pkgs;[
    eza zoxide bat fzf ripgrep
    uutils-coreutils
  ];
}
