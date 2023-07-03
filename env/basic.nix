{ pkgs, ... }:

let
  username = "nightmare";
in
{
  imports = [
    ./shared.nix
  ];

  services.openssh.enable = true;
  virtualisation.docker.enable = true;
  programs.ssh.startAgent = true;

  system.stateVersion = "unstable";
}
