{ pkgs, ... }:
{
  environment.systemPackages = with pkgs;[
    exa zoxide bat fzf ripgrep
  ];
}
