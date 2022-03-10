{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";

    dotfiles = {
      url = "github:s0la1337/dotfiles";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, dotfiles }@inputs: {
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
          ./machines/wsl/wsl_colemak.nix
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
