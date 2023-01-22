{ pkgs, ... }:

let
  defaultUser = "dreamer";
in
{
  imports = [
    ./shared.nix
  ];

  users.users.${defaultUser} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    password = "12345";
    extraGroups = [ "wheel" ];
  };

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  system.stateVersion = "unstable";
}
