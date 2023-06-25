{ pkgs, ... }:
{
  imports = [
    ../../configuration.nix
  ];

  services.nix-daemon.enable = true;
  nix.useDaemon = true;
  nix.configureBuildUsers = true;

  programs.zsh.enable = true;
  programs.zsh.shellInit = ''
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
  '';

  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
