{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "neoncity";
  networking.networkmanager.enable = true;

  sound.enable = true;

  time.timeZone = "Europe/Berlin";

  fonts.fonts = with pkgs; [
    jetbrains-mono
    meslo-lgs-nf
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  users.users."dreamer" = {
    isNormalUser = true;
    initialPassword = "12345";
    group = "users";
    extraGroups = [ "wheel" "networkmanager" ];

    shell = pkgs.zsh;
  };

  home-manager.users."dreamer" = { pkgs, nixpkgs, ...}: {
    imports = [
      # User applications
      ./alacritty.nix
      ./userApps.nix
      ./x11.nix

      # General purpose
      ../../general_purpose/nvim.nix
      ../../general_purpose/zsh.nix

      # development
      ../../development/c.nix
      ../../development/zig.nix
      ../../development/rust.nix
      ../../development/misc.nix
    ];

    home.stateVersion = "21.11";
    home.keyboard.layout = "us";
  };
}
