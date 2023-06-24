{ pkgs, user, ... }:
{
  programs.zsh.enable = true;
  users.users.${user} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    password = "12345";
    extraGroups = [ "wheel" "networkmanager" "audio" ];
  };

}
