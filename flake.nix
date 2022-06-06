{
  inputs = {
    nixpkgs.url        = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    zig-master.url     = "github:arqv/zig-overlay";
    # nur.url          = "github:nix-community/NUR"; # not used yet, but make it accessible when i need to use it.

    grub2-theme = {
      url                    = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dotfiles = {
      url   = "github:s0la1337/dotfiles";
      flake = false;
    };

    sddm-theme = {
      url   = "github:s0la1337/tokyo-night-sddm";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, dotfiles, nixos-hardware,
    sddm-theme, neovim-nightly, zig-master, grub2-theme }@inputs: {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem { 
        system  = "x86_64-linux";
        modules = [
          ./machines/wsl/wsl.nix
          ./development/global.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs    = true;
            home-manager.useUserPackages  = true;
            home-manager.extraSpecialArgs = { inherit 
            dotfiles neovim-nightly zig-master; };
            home-manager.users.neoncity   = { ... }: {
              imports = [ ./profiles/wsl/default.nix ];
            };
          }
        ];
      };

      wsl_colemak = nixpkgs.lib.nixosSystem { 
        system  = "x86_64-linux";
        modules = [
          ./machines/wsl/wsl.nix
          ./development/global.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs    = true;
            home-manager.useUserPackages  = true;
            home-manager.extraSpecialArgs = { inherit 
            dotfiles neovim-nightly zig-master; };
            home-manager.users.neoncity   = { ... }: {
              imports = [ ./profiles/wsl-colemak/default.nix ];
            };
          }
        ];
      };

      neoncity = nixpkgs.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit sddm-theme grub2-theme; };
        modules     = [
          ./machines/thinkpad-t420/t420.nix
          ./development/global.nix
          ./ui/sddm.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t420
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs    = true;
            home-manager.useUserPackages  = true;
            home-manager.extraSpecialArgs = { inherit 
            dotfiles neovim-nightly zig-master; };
            home-manager.users.dreamer    = { ... }: {
              imports = [ ./profiles/dreamer/default.nix ];
            };
          }
        ];
      };

      nc_wl = nixpkgs.lib.nixosSystem {
        system      = "x86_64-linux";
        specialArgs = { inherit sddm-theme grub2-theme; };
        modules     = [
          ./machines/thinkpad-t420/t420_wl.nix
          ./development/global.nix
          ./ui/sddm.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t420
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs    = true;
            home-manager.useUserPackages  = true;
            home-manager.extraSpecialArgs = { inherit 
            dotfiles neovim-nightly zig-master; };
            home-manager.users.dreamer    = { ... }: {
              imports = [ ./profiles/dreamer_wl/default.nix ];
            };
          }
        ];
      };
    };
  };
}
