{pkgs, username, ...}: {

  environment.sessionVariables = {
    FLAKE = "/home/${username}/dev/nixos-config";
  };

  environment.systemPackages = with pkgs; [
    nh nvd nix-output-monitor
    eza
    zoxide
    bat
    fzf
    ripgrep
    uutils-coreutils
  ];
}
