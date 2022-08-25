{ pkgs, ... }:

let
  defaultUser = "dreamer";
in
{
  users.users.${defaultUser} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  system.stateVersion = "22.11";
}
