{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nur.url = github:nix-community/NUR;
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    helix-master.url = "github:SoraTenshi/helix/experimental";
    grub2-theme.url = "github:vinceliuice/grub2-themes";
    home-manager.url = "github:nix-community/home-manager";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nil.url = "github:oxalica/nil";

    # Non-flakes
    known-folders = {
      url = "github:ziglibs/known-folders/master";
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
    , grub2-theme
    , helix-master
    , picom-ibhagwan
    , emacs-overlay
    , nur
    , nil
    }@inputs:
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
              zig build install -Dcpu=baseline -Drelease-safe=true -Ddata_version=master -Dknown-folders=${known-folders.outPath}/known-folders.zig --prefix $out
            '';
          });
          dmenu = prev.zls.overrideAttrs (c: {
            patches = (c.patches or []) ++ [
              "${self}/dmenu-patches/dmenu-alpha.diff"
              "${self}/dmenu-patches/dmenu-border.diff"
              "${self}/dmenu-patches/dmenu-center.diff"
              "${self}/dmenu-patches/dmenu-fuzzymatch.diff"
            ];
          });
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
          system = system;
          modules = [
            ./machines/wsl/wsl.nix
            ./development/global.nix
            home-manager.nixosModules.home-manager
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
          system = system;
          specialArgs = { inherit sddm-theme grub2-theme; };
          modules = [
            ./machines/battlestation/battlestation.nix
            ./env/nvidia.nix
            ./development/global.nix
            ./ui/x11/sddm.nix
            ./ui/x11/xserver/battlestation.nix
            home-manager.nixosModules.home-manager
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
          system = system;
          specialArgs = { inherit sddm-theme grub2-theme; };
          modules = [
            ./machines/thinkpad-t470/t470.nix
            ./development/global.nix
            ./ui/x11/sddm.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-t470s
            home-manager.nixosModules.home-manager
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
          system = system;
          specialArgs = { inherit sddm-theme grub2-theme; };
          modules = [
            ./machines/thinkpad-t420/t420.nix
            ./development/global.nix
            ./ui/sddm.nix
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
