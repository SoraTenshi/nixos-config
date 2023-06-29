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

  system.defaults = {
    dock = {
      autohide = true;
      autohide-time-modifier = 0.0;
      expose-animation-duration = 0.0;
      orientation = "right";
    };
    finder.CreateDesktop = false;
    trackpad = {
      Clicking = true;
      Dragging = true;
    };
    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  };

  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
