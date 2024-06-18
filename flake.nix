{
  description = "My personal NixOS / Darwin flake.";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    stylix.url = "github:danth/stylix";
    nur.url = "github:nix-community/NUR";

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    grub2-theme.url = "github:vinceliuice/grub2-themes";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.1.0";

    nix-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      url = "github:zigtools/zls";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    vfio = {
      url = "github:j-brn/nixos-vfio";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags-env = {
      url = "github:SoraTenshi/ags-env";
      flake = false;
    };

    picom-ibhagwan = {
      url = "github:ibhagwan/picom";
      flake = false;
    };

    sddm-theme = {
      url = "github:SoraTenshi/tokyo-night-sddm";
      flake = false;
    };

    coplandos = {
      url = "github:ioresolution/copland-plymouth-theme";
      flake = false;
    };
  };

  outputs = { self, nixpkgs-nixos, nixpkgs, nur, home-manager, nixos-hardware
    , sddm-theme, neovim-nightly, zig-overlay, zls-master, grub2-theme
    , helix-master, picom-ibhagwan, nixos-wsl, darwin, stylix, ags, ags-env
    , vfio, nix-flatpak, nix-cosmic, coplandos, hyprland, }:
    let
      mkDarwin = import ./lib/mkdarwin.nix;
      mkNixOS = import ./lib/mknixos.nix;

      overlays = [ zig-overlay.overlays.default ];
    in {
      nixosConfigurations = {
        plutonium = mkNixOS "plutonium" {
          inherit self home-manager helix-master neovim-nightly overlays
            zls-master nur;
          nixpkgs = nixpkgs-nixos;
          isHardwareMachine = false;
          system = "x86_64-linux";
          username = "nightmare";
          extraModules = [ ./modules/distcc nixos-wsl.nixosModules.wsl ];
          extraHomeModules = [ ];
        };

        battlestation = mkNixOS "battlestation" {
          inherit self home-manager helix-master neovim-nightly overlays
            zls-master picom-ibhagwan sddm-theme grub2-theme nur ags-env
            coplandos hyprland;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dreamer";
          efiSysMountPoint = "/boot/efi";
          extraModules = [
            ./modules/nvidia
            ./modules/greetd
            # ./modules/libvirtd
            # nix-cosmic.nixosModules.default
            # vfio.nixosModules.vfio
            stylix.nixosModules.stylix
          ];
          extraHomeModules = [
            ags.homeManagerModules.default
            nix-flatpak.homeManagerModules.nix-flatpak
          ];
          monitors = [
            "DP-3,1920x1080@165,0x1080"
            "DP-2,1920x1080@75,1920x1080"
            "HDMI-A-1,1920x1080@60,960x0"
          ];
        };

        serotonine = mkNixOS "serotonine" {
          inherit self home-manager helix-master neovim-nightly picom-ibhagwan
            overlays zls-master sddm-theme grub2-theme nur;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dreamer";
          extraModules = [
            ./modules/greetd
            nixos-hardware.nixosModules.lenovo-thinkpad-t470s
            stylix.nixosModules.stylix
          ];
          extraHomeModules = [
            ags.homeManagerModules.default
            # nix-flatpak.homeManagerModules.nix-flatpak
          ];
        };

        radium = mkNixOS "radium" {
          inherit self home-manager helix-master neovim-nightly picom-ibhagwan
            overlays zls-master sddm-theme grub2-theme nur;
          nixpkgs = nixpkgs-nixos;
          system = "aarch64-linux";
          username = "spectre";
          isVM = true;
          useStylix = false;
          extraModules = [ ./modules/greetd ];
        };

        loqius = mkNixOS "loqius" {
          inherit self home-manager helix-master neovim-nightly overlays
            zls-master picom-ibhagwan sddm-theme grub2-theme nur hyprland;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dev";
          extraModules = [ ./modules/greetd stylix.nixosModules.stylix ];
          extraHomeModules = [ ags.homeManagerModules.default ];
          monitors = [
            "eDP-1,1920x1080@60,0x0"
            "HDMI-A-1,1920x1080@120,1920x0"
            "DP-1,1920x1080@75,3840x0"
          ];
        };
      };

      darwinConfigurations = {
        combustible = mkDarwin "combustible" {
          inherit self nixpkgs darwin home-manager helix-master overlays
            zls-master nur;
          system = "aarch64-darwin";
          username = "lemon";
        };
      };
    };
}
