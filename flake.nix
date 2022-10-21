{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    zig-master.url = "github:mitchellh/zig-overlay";
    helix-master.url = "github:SoraTenshi/helix/experimental";
    grub2-theme.url = "github:vinceliuice/grub2-themes";
    home-manager.url = "github:nix-community/home-manager";

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
    , nixpkgs-unstable
    , home-manager
    , nixos-hardware
    , sddm-theme
    , neovim-nightly
    , zig-master
    , grub2-theme
    , helix-master
    , picom-ibhagwan
    }@inputs:
    let
      system = "x86_64-linux";
      overlays = [
        (final: prev: {
          picom = prev.picom.overrideAttrs (o: { src = picom-ibhagwan; });
        })
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
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  self neovim-nightly zig-master helix-master;
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
              nixpkgs.overlays = overlays;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  self neovim-nightly zig-master helix-master picom-ibhagwan;
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
              nixpkgs.overlays = overlays;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit
                  self neovim-nightly zig-master helix-master picom-ibhagwan;
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
                  neovim-nightly zig-master helix-master;
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
