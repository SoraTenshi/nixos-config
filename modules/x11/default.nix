{ ... }:
{
  services.xserver = {
    enable = true;
    layout = "eu";
    displayManager.defaultSession = "none+xmonad";
    desktopManager.runXdgAutostartIfNone = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        pkgs.xmonad-log
      ];
      config = ./xmonad.hs;
    };
  };
}
