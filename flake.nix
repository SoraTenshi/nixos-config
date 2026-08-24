{
  description = "My personal NixOS / Darwin flake.";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    stylix.url = "github:danth/stylix";
    nur.url = "github:nix-community/NUR";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    ghostty.url = "github:ghostty-org/ghostty";

    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    zen-browser = {
      url = "github:maximoffua/zen-browser.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    binary-ninja = {
      url = "github:jchv/nix-binary-ninja";
    };
  };

  outputs = inputs @ { self, nixpkgs-nixos, nixpkgs, nur, home-manager, nixos-hardware
    , nixos-wsl, darwin, stylix, nix-flatpak
    , hyprland, zen-browser, binary-ninja , ghostty, spicetify, }:
    let
      mkDarwin = import ./lib/mkdarwin.nix;
      mkNixOS = import ./lib/mknixos.nix;

      overlays = [ ];
    in {
      nixosConfigurations = {
        plutonium = mkNixOS "plutonium" {
          inherit inputs overlays;
          nixpkgs = nixpkgs-nixos;
          isHardwareMachine = false;
          system = "x86_64-linux";
          username = "nightmare";
          useTokyoNight = false;
          useAndroidEmulation = true;
          extraModules = [
            nixos-wsl.nixosModules.wsl
            nix-flatpak.nixosModules.nix-flatpak
          ];
          extraHomeModules = [
            stylix.homeModules.default
          ];
        };

        battlestation = mkNixOS "battlestation" {
          inherit inputs overlays;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dreamer";
          useSecureBoot = true;
          useArcan = true;
          useAndroidEmulation = true;
          useDualBoot = true;
          useChromium = true;
          useTokyoNight = false;
          extraModules = [
            ./modules/nvidia
            ./modules/ly
            ./modules/steam
            stylix.nixosModules.stylix
            nix-flatpak.nixosModules.nix-flatpak
          ];
          extraHomeModules = [
            spicetify.homeManagerModules.default
            stylix.homeModules.default
          ];
          monitors = [
            "DP-3,1920x1080@165,0x1080"
            "DP-2,1920x1080@75,1920x1080"
            "HDMI-A-1,1920x1080@60,960x0"
          ];
          autostart = [
            "[workspace 1 silent] ghostty"
            "[workspace 2 silent] zen"
            "[workspace 8 silent] discordcanary"
          ];
        };

        serotonine = mkNixOS "serotonine" {
          inherit inputs overlays;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dreamer";
          useAndroidEmulation = true;
          useArcan = true;
          useChromium = true;
          useTokyoNight = false;
          extraModules = [
            ./modules/ly
            ./modules/steam
            nixos-hardware.nixosModules.lenovo-thinkpad-t470s
            stylix.nixosModules.stylix
            nix-flatpak.nixosModules.nix-flatpak
          ];
          extraHomeModules = [
            spicetify.homeManagerModules.default
            stylix.homeModules.default
          ];
        };
      };

      darwinConfigurations = {
        combustible = mkDarwin "combustible" {
          inherit inputs overlays nixpkgs;
          system = "aarch64-darwin";
          username = "lemon";
          useTokyoNight = false;
          extraModules = [
            # ./modules/mullvad
          ];
        };
      };
    };
}
