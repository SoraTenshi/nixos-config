{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nur.url = "github:nix-community/NUR"; # not used yet, but make it accessible when i need to use it.
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland"; 

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    dotfiles = {
      url = "github:s0la1337/dotfiles";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, dotfiles, nixos-hardware }@inputs: {
    nixosConfigurations = {
      wsl = nixpkgs.lib.nixosSystem { 
        system = "x86_64-linux";
        modules = [ 
          ./machines/wsl/wsl.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit dotfiles; };
            home-manager.users.nixos = { ... }: {
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
            home-manager.extraSpecialArgs = { inherit dotfiles; };
            home-manager.users.nixos = { ... }: {
              imports = [ ./profiles/wsl-colemak/default.nix ];
            };
          }
        ];
      };
      neoncity = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./machines/thinkpad-t420/t420.nix
          nixos-hardware.nixosModules.lenovo-thinkpad-t420
          nixos-hardware.nixosModules.common-pc-ssd
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit dotfiles; };
            home-manager.users.dreamer = { ... }: {
              imports = [ ./profiles/dreamer/default.nix ];
            };
          }
        ];
      };
    };
  };
}
