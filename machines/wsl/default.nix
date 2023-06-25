{ ... }:

let 
  username = "nightmare";
in
{
  imports = [
    ../../configuration.nix
    ../../env/basic.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "${username}";
    startMenuLaunchers = true;
    nativeSystemd = true;
    interop.register = false;
  };
}
