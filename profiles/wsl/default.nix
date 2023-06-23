{ self, ... }:
{
  home.stateVersion = "23.05";
  imports = [
    # General purpose
    (/. + "${self}/home/kitty")
    (/. + "${self}/home/misc")
    (/. + "${self}/home/development")
    (/. + "${self}/home/shells/zsh")
  ];
}
