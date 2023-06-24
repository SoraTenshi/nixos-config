{ ... }:
{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      
    '';
  };

  system.keyboard.enableKeyMapping = true;
}
