{ pkgs, ... }: {
  nix = {
    package = pkgs.nixVersions.stable;
    optimise.automatic = true;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  programs.zsh.enable = true;
  environment.shells = [ pkgs.bashInteractive pkgs.zsh ];
  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  environment.pathsToLink = [ "/share/zsh" ];
}
