{ username, ... }: {
  imports = [ ../../configuration.nix ];

  wsl = {
    enable = true;
    defaultUser = "${username}";
    startMenuLaunchers = true;
    interop.register = false;
  };
  networking.hostName = "plutonium"; # because it glows... got it?

  services.tailscale.enable = true;
  system.stateVersion = "24.11";
}
