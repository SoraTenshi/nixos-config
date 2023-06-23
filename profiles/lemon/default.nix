{ self, ... }:
let
  home = "${self}/home/";
  join = builtins.concatPaths;
in
{
  imports = [
    join [home "kitty"]
    join [home "editors" "helix"]
    join [home "shells" "zsh"]
    join [home "misc"]
  ];
}
