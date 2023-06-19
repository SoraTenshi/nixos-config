{ pkgs, ... }:
let 
  defaultUser = "dreamer";
in
{
  programs.zsh.enable = true;
  users.users.${defaultUser} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    password = "12345";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

}
