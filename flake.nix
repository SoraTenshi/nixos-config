{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    helix-master.url = "github:SoraTenshi/helix/experimental-22.12";
    grub2-theme.url = "github:vinceliuice/grub2-themes";
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    # Non-flakes
    known-folders = {
      url = "github:ziglibs/known-folders";
      flake = false;
    };

    tres = {
      url = "github:ziglibs/tres";
      flake = false;
    };

    zls-master = {
      url = "github:zigtools/zls/master";
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
    , known-folders
    , tres
    , grub2-theme
    , helix-master
    , picom-ibhagwan
    , emacs-overlay
    , nur
    , nixos-wsl
    }:
    let
      system = "x86_64-linux";
      
      overlays = [
        (final: prev: {
          picom = prev.picom.overrideAttrs (c: { src = picom-ibhagwan; });
          zls = prev.zls.overrideAttrs (c: {
            version = "master";
            src = zls-master;
            dontConfigure = true;
            dontInstall = false;
            nativeBuildInputs = [ zig-overlay.packages.${system}.master ];
            installPhase = ''
              zig build install -Dcpu=baseline -Drelease-safe=true -Ddata_version=master -Dtres=${tres.outPath}/tres.zig -Dknown-folders=${known-folders.outPath}/known-folders.zig --prefix $out
            '';
          });
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
          material-symbols = prev.callPackage ./derivations/material-symbols/material-symbols.nix {};
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
                  self neovim-nightly helix-master;
              };
              home-manager.users.dreamer = { ... }: {
                imports = [ ./profiles/wsl/default.nix ];
              };
            }
          ];
        };

        battlestation = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit sddm-theme grub2-theme; };
          modules = [
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
                  self neovim-nightly helix-master picom-ibhagwan;
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
                  self neovim-nightly helix-master picom-ibhagwan;
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
