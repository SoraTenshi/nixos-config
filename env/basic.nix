{ pkgs, ... }:

let
  username = "nightmare";
in
{
  imports = [
    ./shared.nix
  ];

  programs.zsh.enable = true;
  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    password = "12345";
    extraGroups = [ "wheel" ];
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Berlin";
  };

  services.openssh.enable = true;
  virtualisation.docker.enable = true;
  programs.ssh.startAgent = true;

  system.stateVersion = "unstable";
}
