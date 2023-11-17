{
  description = "My personal NixOS / Darwin flake.";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    stylix.url = "github:danth/stylix";
    nur.url = "github:nix-community/NUR";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
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

    anyrun = {
      url = "github:Kirottu/anyrun";
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
    , nur
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
    , stylix
    , anyrun
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
        plutonium = mkNixOS "plutonium" {
          inherit self home-manager helix-master neovim-nightly overlays zls-master nur;
          nixpkgs = nixpkgs-nixos;
          isHardwareMachine = false;
          system = "x86_64-linux";
          username = "nightmare";
          extraModules = [
            ./modules/distcc
            nixos-wsl.nixosModules.wsl
          ];
        };

        battlestation = mkNixOS "battlestation" {
          inherit self home-manager helix-master neovim-nightly overlays zls-master picom-ibhagwan sddm-theme grub2-theme nur anyrun;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dreamer";
          extraModules = [
            ./modules/sddm
            ./modules/nvidia
            stylix.nixosModules.stylix
          ];
          extraHomeModules = [
            anyrun.homeManagerModules.default
          ];
        };

        serotonine = mkNixOS "serotonine" {
          inherit self home-manager helix-master neovim-nightly picom-ibhagwan overlays zls-master sddm-theme grub2-theme nur anyrun;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dreamer";
          extraModules = [
            ./modules/sddm
            nixos-hardware.nixosModules.lenovo-thinkpad-t470s
            stylix.nixosModules.stylix
          ];
          extraHomeModules = [
            anyrun.homeManagerModules.default
          ];
        };

        radium = mkNixOS "radium" {
          inherit self home-manager helix-master neovim-nightly picom-ibhagwan overlays zls-master sddm-theme grub2-theme nur;
          nixpkgs = nixpkgs-nixos;
          system = "aarch64-linux";
          username = "spectre";
          isVM = true;
          extraModules = [
            ./modules/sddm
          ];
        };

        loqius = mkNixOS "loqius" {
          inherit self home-manager helix-master neovim-nightly picom-ibhagwan overlays zls-master sddm-theme grub2-theme nur anyrun;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dev";
          extraModules = [
            ./modules/sddm
            nixos-hardware.nixosModules.lenovo-thinkpad-l14-amd
            stylix.nixosModules.stylix
          ];
          extraHomeModules = [
            anyrun.homeManagerModules.default
          ];
        };
      };

      darwinConfigurations = {
        combustible = mkDarwin "combustible" {
          inherit self nixpkgs darwin home-manager helix-master neovim-nightly overlays zls-master nur;
          system = "aarch64-darwin";
          username = "lemon";
        };
      };
    };
}
