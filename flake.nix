{
  description = "My personal NixOS / Darwin flake.";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    helix-master.url = "github:SoraTenshi/helix/new-daily-driver";
    grub2-theme.url = "github:vinceliuice/grub2-themes";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    zls-master.url = "github:zigtools/zls/master";

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
    , emacs-overlay
    , nur
    , nixos-wsl
    , nix-gaming
    , darwin
    }:
    let
      hosts = {
        "battlestation" = "x86_64-linux";
        "combustible" = "aarch64-darwin";
        "t470" = "x86_64-linux";
        "wsl" = "x86_64-linux";
      };

      system = "x86_64-linux";
      
      overlays = [
        (final: prev: {
          zls = zls-master.packages.${system}.default;
          picom = prev.picom.overrideAttrs (c: { src = picom-ibhagwan; });
          river = prev.river.overrideAttrs (c: {
            installPhase = ''
                runHook preInstall
                zig build -Drelease-safe -Dcpu=baseline -Dxwayland -Dman-pages --prefix $out install
                runHook postInstall
            '';
            postInstall = 
              let 
                riverSession = ''
                  [Desktop Entry]
                  Name=River
                  Comment=Dynamic Wayland compositor
                  Exec=river
                  Type=Application
                '';
              in
                ''
                  mkdir -p $out/share/wayland-sessions
                  echo "${riverSession}" > $out/share/wayland-sessions/river.desktop
                '';
          });
          material-symbols = prev.callPackage ./derivations/material-symbols {};
        })
      ];
      otherOverlays = [
        emacs-overlay.overlay
        nur.overlay
        zig-overlay.overlays.default
      ];
    in
    {
      nixosConfigurations = {
        wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./machines/wsl
            ./home/development
            nixos-wsl.nixosModules.wsl
            home-manager.nixosModules.home-manager
            nur.nixosModules.nur # for config.nur
            ({ config, ... }:{
              home-manager.sharedModules = [
                config.nur.repos.rycee.hmModules.emacs-init
              ];
            })
            {
              nixpkgs.overlays = overlays ++ otherOverlays;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  self neovim-nightly helix-master;
              };
              home-manager.users.dreamer = { ... }: {
                imports = [ ./profiles/wsl ];
              };
            }
          ];
        };

        battlestation = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit sddm-theme grub2-theme nix-gaming; };
          modules = [
            ./ui/arcan
            ./machines/battlestation
            ./modules/nvidia
            ./home/development
            ./ui/x11/xserver
            home-manager.nixosModules.home-manager
            nur.nixosModules.nur # for config.nur
            ({ config, ... }:{
              home-manager.sharedModules = [
                config.nur.repos.rycee.hmModules.emacs-init
              ];
            })
            {
              nixpkgs.overlays = overlays ++ otherOverlays;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  self neovim-nightly helix-master picom-ibhagwan;
              };
              home-manager.users.dreamer = { ... }: {
                imports = [ ./profiles/dreamer ];
              };
            }
          ];
        };

        t470 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit sddm-theme grub2-theme; };
          modules = [
            ./ui/arcan
            ./machines/thinkpad-t470
            ./home/development
            nixos-hardware.nixosModules.lenovo-thinkpad-t470s
            home-manager.nixosModules.home-manager
            nur.nixosModules.nur # for config.nur
            ({ config, ... }:{
              home-manager.sharedModules = [
                config.nur.repos.rycee.hmModules.emacs-init
              ];
            })
            {
              nixpkgs.overlays = overlays ++ otherOverlays;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  self neovim-nightly helix-master picom-ibhagwan;
              };
              home-manager.users.dreamer = { ... }: {
                imports = [ ./profiles/dreamer ];
              };
            }
          ];
        };
      };

      darwinConfigurations = {
        combustible = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = import nixpkgs { system = "aarch64-darwin"; };
          modules = [
            ./machines/combustible
            home-manager.darwinModules.home-manager
            {
              nixpkgs.overlays = overlays ++ otherOverlays;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  self neovim-nightly helix-master;
              };
              home-manager.users.lemon = { ... }: {
                imports = [ ./profiles/lemon ];
              };
            }
          ];
        };
      };
    };
}