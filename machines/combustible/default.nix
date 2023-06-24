{ pkgs, ... }:
{
  nix.useDaemon = true;

  programs.zsh.shellInit = ''
    # Nix
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi
    # End Nix
  '';

  environment.shells = [ pkgs.bashInteractive pkgs.zsh pkgs.bash ];
}
