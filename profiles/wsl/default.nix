{ self, ... }:
let
  home = "${self}/home/";
  join = builtins.concatPaths;
in
{
  home.stateVersion = "23.05";
  imports = [
    # General purpose
    join [home "kitty"]
    join [home "misc"]
    join [home "development"]
    join [home "shells" "zsh"]
  ];
}
