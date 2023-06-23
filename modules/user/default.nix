{ pkgs, username, ... }:
{
  programs.zsh.enable = true;
  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    password = "12345";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

}
