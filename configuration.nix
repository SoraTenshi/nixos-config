{pkgs, ...}: {
  nix = {
    package = pkgs.nixFlakes;
    settings.auto-optimise-store = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  programs.zsh.enable = true;
  environment.shells = [pkgs.bashInteractive pkgs.zsh];

  environment.pathsToLink = ["/share/zsh"];
}
