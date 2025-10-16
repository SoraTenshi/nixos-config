{
  description = "My personal NixOS / Darwin flake.";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    stylix.url = "github:danth/stylix";
    nur.url = "github:nix-community/NUR";

    ags.url = "github:aylur/ags/v1";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.1.0";

    ghostty.url = "github:ghostty-org/ghostty";

    darwin = {
      url = "github:lnl7/nix-darwin/master";
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

    helix-master = {
      url = "github:SoraTenshi/helix/new-daily-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix-steel = {
      url = "github:mattwparas/helix/steel-event-system";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zls-master = {
      url = "github:zigtools/zls";
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

    ags-env = {
      url = "github:SoraTenshi/ags-env";
      flake = false;
    };

    lem = {
      url = "github:lem-project/lem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs-nixos, nixpkgs, nur, home-manager, nixos-hardware
    , zls-master , helix-master, nixos-wsl, darwin, stylix, ags, ags-env
    , nix-flatpak, hyprland, zen-browser, binary-ninja
    , ghostty, spicetify, helix-steel, lem, }:
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
          tokyo-night = false;
          useAndroidEmulation = true;
          extraModules = [
            nixos-wsl.nixosModules.wsl
          ];
          extraHomeModules = [
          ];
        };

        battlestation = mkNixOS "battlestation" {
          inherit inputs overlays;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dreamer";
          useSecureBoot = false;
          useArcan = true;
          useAndroidEmulation = true;
          useChromium = true;
          extraModules = [
            ./modules/nvidia
            ./modules/ly
            ./modules/steam
            # ./modules/libvirtd
            # vfio.nixosModules.vfio
            stylix.nixosModules.stylix
          ];
          extraHomeModules = [
            ags.homeManagerModules.default
            nix-flatpak.homeManagerModules.nix-flatpak
            spicetify.homeManagerModules.default
          ];
          monitors = [https://top.gg/bot/688202466315206661/vote
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

        loqius = mkNixOS "loqius" {
          inherit inputs overlays;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dev";
          useAndroidEmulation = true;
          tokyo-night = false;
          extraModules = [
            # ./modules/greetd
            ./modules/ly
            stylix.nixosModules.stylix
          ];
          extraHomeModules = [
            ags.homeManagerModules.default
            spicetify.homeManagerModules.default
          ];
          monitors = [
            "eDP-1,1920x1200@60,0x0"
            "HDMI-A-1,1920x1080@120,1920x0"
            "DP-1,1920x1080@75,3840x0"
          ];
          autostart = [
            "[workspace 1 silent] ghostty"
            "[workspace 2 silent] firefox"
            "[workspace 9 silent] keepassxc"
            "[workspace 4 silent] thunderbird"
            "[workspace 5 silent] mumble"
            "[workspace 6 silent] zen"
          ];
        };

        vocatius = mkNixOS "vocatius" {
          inherit inputs overlays;
          nixpkgs = nixpkgs-nixos;
          system = "x86_64-linux";
          username = "dev";
          useArcan = true;
          useChromium = true;
          useAndroidEmulation = true;
          tokyo-night = false;
          extraModules = [
            # ./modules/greetd
            ./modules/steam
            ./modules/ly
            stylix.nixosModules.stylix
          ];
          extraHomeModules = [
            ags.homeManagerModules.default
            spicetify.homeManagerModules.default
          ];
          monitors = [
            "HDMI-A-7,1920x1080@60,960x0"
            "DP-4,1920x1080@165,0x1080"
            "DP-5,1920x1080@60,1920x1080"
          ];
          autostart = [
            "[workspace 1 silent] ghostty"
            "[workspace 2 silent] firefox"
            "[workspace 9 silent] keepassxc"
            "[workspace 4 silent] thunderbird"
            "[workspace 5 silent] mumble"
            "[workspace 6 silent] zen"
          ];
        };
      };

      darwinConfigurations = {
        combustible = mkDarwin "combustible" {
          inherit inputs overlays nixpkgs;
          system = "aarch64-darwin";
          username = "lemon";
          tokyo-night = true;
          extraModules = [
            # ./modules/mullvad
          ];
        };
      };
    };
}
