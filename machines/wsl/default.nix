{ username, ... }:
{
  imports = [
    ../../configuration.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "${username}";
    startMenuLaunchers = true;
    nativeSystemd = true;
    interop.register = false;
  };

  system.stateVersion = "23.05";
  networking.hostName = "plutonium"; # because it glows... got it? 
}
