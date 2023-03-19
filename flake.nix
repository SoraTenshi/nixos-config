{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    helix-master.url = "github:SoraTenshi/helix/daily-driver";
    grub2-theme.url = "github:vinceliuice/grub2-themes";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    zls-master.url = "github:zigtools/zls/master";


    # Non-flakes
    codeium = {
      url = "github:Exafunction/codeium.vim";
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

    tokyo-night-gtk = {
      url = "github:Fausto-Korpsvart/Tokyo-Night-GTK-Theme";
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
    , tokyo-night-gtk
    , nix-gaming
    , codeium
    }:
    let
      system = "x86_64-linux";
      
      overlays = [
        (final: prev: {
          prev.zls = zls-master.packages.zls;
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
          tokyo-night-gtk = prev.callPackage ./derivations/tokyo-night-gtk {inherit tokyo-night-gtk;};
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
            ./machines/wsl/wsl.nix
            ./development/global.nix
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
                  self neovim-nightly helix-master codeium;
              };
              home-manager.users.dreamer = { ... }: {
                imports = [ ./profiles/wsl/default.nix ];
              };
            }
          ];
        };

        battlestation = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit sddm-theme grub2-theme nix-gaming; };
          modules = [
            ./ui/arcan/default.nix
            ./machines/battlestation/battlestation.nix
            ./env/nvidia.nix
            ./development/global.nix
            ./ui/x11/xserver/battlestation.nix
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
                  self neovim-nightly helix-master picom-ibhagwan codeium;
              };
              home-manager.users.dreamer = { ... }: {
                imports = [ ./profiles/dreamer/default.nix ];
              };
            }
          ];
        };

        t470 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit sddm-theme grub2-theme; };
          modules = [
            ./ui/arcan/default.nix
            ./machines/thinkpad-t470/t470.nix
            ./development/global.nix
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
                  self neovim-nightly helix-master picom-ibhagwan codeium;
              };
              home-manager.users.dreamer = { ... }: {
                imports = [ ./profiles/dreamer/default.nix ];
              };
            }
          ];
        };

        t420 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit sddm-theme grub2-theme; };
          modules = [
            ./machines/thinkpad-t420/t420.nix
            ./development/global.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t420
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  neovim-nightly helix-master;
              };
              home-manager.users.dreamer = { ... }: {
                imports = [ ./profiles/dreamer/default.nix ];
              };
            }
          ];
        };
      };
    };
}
