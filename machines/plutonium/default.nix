{ username, ... }: {
  imports = [ ../../configuration.nix ];

  wsl = {
    enable = true;
    defaultUser = "${username}";
    startMenuLaunchers = true;
    nativeSystemd = true;
    interop.register = false;
  };
  networking.hostName = "plutonium"; # because it glows... got it?

  services.tailscale.enable = true;
  system.stateVersion = "unstable";
}
