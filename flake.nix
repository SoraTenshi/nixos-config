{
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    helix-master.url = "github:SoraTenshi/helix/experimental";
    grub2-theme.url = "github:vinceliuice/grub2-themes";
    home-manager.url = "github:nix-community/home-manager";
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    zls-overlay = {
      url = "github:zigtools/zls/master";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        zig-overlay.follows = "zig-overlay";
      };
    };

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
    , grub2-theme
    , helix-master
    , picom-ibhagwan
    , emacs-overlay
    , zls-overlay
    }@inputs:
    let
      system = "x86_64-linux";
      
      overlays = [
        (final: prev: {
          picom = prev.picom.overrideAttrs (c: { src = picom-ibhagwan; });
          # zls = prev.zls.overrideAttrs (c: { src = zls-overlay; }); # seems to be broken for now (prolly 0.10 release)
        })
      ];
      otherOverlays = [
        emacs-overlay.overlay
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
                  self neovim-nightly zig-overlay helix-master;
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
                  self neovim-nightly zig-overlay helix-master picom-ibhagwan;
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
                  self neovim-nightly zig-overlay helix-master picom-ibhagwan;
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
                  neovim-nightly zig-overlay helix-master;
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
