{
  description = "My personal NixOS / Darwin flake.";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    stylix.url = "github:danth/stylix";
    nur.url = "github:nix-community/NUR";

    ags = {
      url = "github:aylur/ags/v1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    grub2-theme.url = "github:vinceliuice/grub2-themes";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.1.0";

    ghostty-package.url = "github:ghostty-org/ghostty";
    ghostty.url = "github:clo4/ghostty-hm-module";

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
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    vfio = {
      url = "github:j-brn/nixos-vfio";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:MarceColl/zen-browser-flake";
    };

    binary-ninja = {
      url = "github:jchv/nix-binary-ninja";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
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

  outputs = inputs @ { self, nixpkgs-nixos, nixpkgs, nur, home-manager, nixos-hardware
    , sddm-theme, neovim-nightly, zig-overlay, zls-master, grub2-theme
    , helix-master, picom-ibhagwan, nixos-wsl, darwin, stylix, ags, ags-env
    , vfio, nix-flatpak, nix-cosmic, coplandos, hyprland, zen-browser, binary-ninja, lanzaboote
    , ghostty, ghostty-package, }:
    let
      mkDarwin = import ./lib/mkdarwin.nix;
      mkNixOS = import ./lib/mknixos.nix;

      overlays = [ zig-overlay.overlays.default ];
    in {
      nixosConfigurations = {
        plutonium = mkNixOS "plutonium" {
          inherit inputs overlays;
          nixpkgs = nixpkgs-nixos;
          isHardwareMachine = false;
          system = "x86_64-linux";
          username = "nightmare";
          extraModules = [
            ./modules/distcc
            nixos-wsl.nixosModules.wsl
          ];
          extraHomeModules = [
            ghostty.homeModules.default
          ];
        };

        battlestation = mkNixOS "battlestation" {
          inherit inputs overlays;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dreamer";
          useSecureBoot = false;
          efiSysMountPoint = "/boot/efi";
          extraModules = [
            ./modules/nvidia
            ./modules/greetd
            # ./modules/libvirtd
            # nix-cosmic.nixosModules.default
            # vfio.nixosModules.vfio
            lanzaboote.nixosModules.lanzaboote
            stylix.nixosModules.stylix
          ];
          extraHomeModules = [
            ags.homeManagerModules.default
            ghostty.homeModules.default
            nix-flatpak.homeManagerModules.nix-flatpak
          ];
          monitors = [
            "DP-3,1920x1080@165,0x1080"
            "DP-2,1920x1080@75,1920x1080"
            "HDMI-A-1,1920x1080@60,960x0"
          ];
        };

        serotonine = mkNixOS "serotonine" {
          inherit inputs overlays;
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
            ghostty.homeModules.default
            # nix-flatpak.homeManagerModules.nix-flatpak
          ];
        };

        radium = mkNixOS "radium" {
          inherit inputs overlays;
          nixpkgs = nixpkgs-nixos;
          system = "aarch64-linux";
          username = "spectre";
          isVM = true;
          useStylix = false;
          extraModules = [ ./modules/greetd ];
        };

        loqius = mkNixOS "loqius" {
          inherit inputs overlays;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dev";
          extraModules = [
            # ./modules/greetd
            ./modules/ly
            stylix.nixosModules.stylix
          ];
          extraHomeModules = [
            ags.homeManagerModules.default
            ghostty.homeModules.default
          ];
          monitors = [
            "eDP-1,1920x1200@60,0x0"
            "HDMI-A-1,1920x1080@120,1920x0"
            "DP-1,1920x1080@75,3840x0"
          ];
        };

        vocatius = mkNixOS "vocatius" {
          inherit inputs overlays;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dev";
          extraModules = [
            # ./modules/greetd
            ./modules/ly
            stylix.nixosModules.stylix
          ];
          extraHomeModules = [
            ags.homeManagerModules.default
            ghostty.homeModules.default
          ];
          monitors = [
            "HDMI-A-7,1920x1080@60,960x0"
            "DP-4,1920x1080@165,0x1080"
            "DP-5,1920x1080@60,1920x1080"
          ];
        };
      };

      darwinConfigurations = {
        combustible = mkDarwin "combustible" {
          inherit inputs overlays;
          system = "aarch64-darwin";
          username = "lemon";
        };
      };
    };
}
