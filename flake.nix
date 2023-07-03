{
  description = "My personal NixOS / Darwin flake.";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # i will probably just pin everything from now on. 
    # no more unstable.
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.05-darwin";

    # but then on the other side...
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-master = {
      url = "github:SoraTenshi/helix/new-daily-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zls-master = {
      url = "github:zigtools/zls/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    grub2-theme.url = "github:vinceliuice/grub2-themes";

    # Non-flakes
    picom-ibhagwan = {
      url = "github:ibhagwan/picom";
      flake = false;
    };

    sddm-theme = {
      url = "github:SoraTenshi/tokyo-night-sddm";
      flake = false;
    };
  };

  outputs =
    { self
    , nixpkgs-nixos
    , nixpkgs
    , home-manager
    , nixos-hardware
    , sddm-theme
    , neovim-nightly
    , zig-overlay
    , zls-master
    , grub2-theme
    , helix-master
    , picom-ibhagwan
    , nixos-wsl
    , darwin
    }:
    let
      mkDarwin = import ./lib/mkdarwin.nix;
      mkNixOS = import ./lib/mknixos.nix;

      overlays = [
        zig-overlay.overlays.default
      ];
    in
    {
      nixosConfigurations = {
        wsl = mkNixOS "wsl" {
          inherit self home-manager helix-master neovim-nightly overlays zls-master;
          nixpkgs = nixpkgs-nixos;
          isHardwareMachine = false;
          system = "x86_64-linux";
          username = "nightmare";
          extraModules = [
            nixos-wsl.nixosModules.wsl
          ];
        };

        battlestation = mkNixOS "battlestation" {
          inherit self home-manager helix-master neovim-nightly overlays zls-master picom-ibhagwan sddm-theme grub2-theme;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dreamer";
          extraModules = [
            ./modules/nvidia
          ];
        };

        serotonine = mkNixOS "serotonine" {
          inherit self home-manager helix-master neovim-nightly picom-ibhagwan overlays zls-master sddm-theme grub2-theme;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dreamer";
          extraModules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-t470s
          ];
        };
      };

      darwinConfigurations = {
        combustible = mkDarwin "combustible" {
          inherit self nixpkgs darwin home-manager helix-master neovim-nightly overlays zls-master;
          system = "aarch64-darwin";
          username = "lemon";
        };
      };
    };
}
