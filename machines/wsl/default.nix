{ self, ... }:

let
  defaultUser = "dreamer";
in
{
  imports = [
    ../../configuration.nix
    ../../env/basic.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "${defaultUser}";
    startMenuLaunchers = true;
    nativeSystemd = true;
    interop.register = false;
  };
}
