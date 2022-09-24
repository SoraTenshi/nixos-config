{ pkgs, ... }:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    
    settings = {
      format = ''
      
      '';
      
      username.format = "[$user]";
      hostname.format = "@[$hostname]";
    };
  };
}
