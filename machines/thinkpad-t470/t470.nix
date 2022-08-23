{ pkgs, config, lib, nixos-hardware, modulesPath, ... }:

let
  defaultUser = "neoncity";
in
{
  imports = [ 
    (modulesPath + "/installer/scan/not-detected.nix")
    ../../configuration.nix
    ../../env/bootable.nix
  ];

  boot = {
    initrd.availableKernelModules = [ "sdhci_pci" "usb_storage" "ehci_pci" ];
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  networking = {
    hostName = "neoncity";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      enp0s25.useDHCP = true;
      wlp3s0.useDHCP = true;
    };
  };
  
    # touchpad support!
  services.xserver.libinput.enable = true;

  console.keyMap = "us";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        mozc
      ];
    };
  };

  time.timeZone = "Europe/Berlin";
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    jetbrains-mono
    meslo-lgs-nf
    rictydiminished-with-firacode
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
