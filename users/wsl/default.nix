{ config, pkgs, ... }:

{
  users.users."nixos" = {
    isNormalUser = true;
    initialPassword = "12345";
    group = "users";
    extraGroups = [ "wheel" ];

    shell = pkgs.zsh;

    home-manager.users."nixos" = { pkgs, nixpkgs, ...}: {
      imports = [
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
    }
}
