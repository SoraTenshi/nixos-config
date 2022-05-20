{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nur.url = "github:nix-community/NUR"; # not used yet, but make it accessible when i need to use it.
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland"; 

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

    dotfiles = {
      url = "github:s0la1337/dotfiles";
      flake = false;
    };

    sddm-theme = {
      url = "github:s0la1337/tokyo-night-sddm";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, dotfiles, nixos-hardware, sddm-theme, nix-doom-emacs }@inputs: {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem { 
        system = "x86_64-linux";
        modules = [ 
          ./machines/wsl/wsl.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit dotfiles nix-doom-emacs; };
            home-manager.users.neoncity = { ... }: {
              imports = [ ./profiles/wsl/default.nix ];
            };
          }
        ];
      };
      wsl_colemak = nixpkgs.lib.nixosSystem { 
        system = "x86_64-linux";
        modules = [ 
          ./machines/wsl/wsl.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit dotfiles nix-doom-emacs; };
            home-manager.users.neoncity = { ... }: {
              imports = [ ./profiles/wsl-colemak/default.nix ];
            };
          }
        ];
      };
      neoncity = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit sddm-theme; };
        modules = [ 
          ./machines/thinkpad-t420/t420.nix
          ./ui/sddm.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t420
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit dotfiles nix-doom-emacs; };
            home-manager.users.dreamer = { ... }: {
              imports = [ ./profiles/dreamer/default.nix ];
            };
          }
        ];
      };
      nc_wl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit sddm-theme; };
        modules = [ 
          ./machines/thinkpad-t420/t420_wl.nix
          ./ui/sddm.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t420
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit dotfiles nix-doom-emacs; };
            home-manager.users.dreamer = { ... }: {
              imports = [ ./profiles/dreamer_wl/default.nix ];
            };
          }
        ];
      };
    };
  };
}
