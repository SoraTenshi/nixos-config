{
  inputs = rec {
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    zig-overlay.url = "github:mitchellh/zig-overlay";
    helix-master.url = "github:SoraTenshi/helix/new-daily-driver";
    grub2-theme.url = "github:vinceliuice/grub2-themes";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    zls-master.url = "github:zigtools/zls/master";

    flake-utils.url = "github:numtide/flake-utils";

    # Darwin specific
    nixpkgs.url = "github:nixos/nixpkgs/release-22.11";
    nixpkgs-darwin.url = "github.com:NixOS/nixpkgs/nixpkgs-23.05-darwin";
    nix-darwin.url = "github:lnl7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin = nix-darwin;

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
    , flake-utils
    , darwin
    , ...
    }@inputs:
    let
      hosts = {
        "battlestation" = "x86_64-linux";
        "lemon"         = "x86_64-linux";
        "combustable"   = "aarch64-darwin";
      };

      # Credits to @Fionera for this great thing
      lib = inputs.nixpkgs.lib;
      isDarwin = lib.systems.inspect.predicates.isDarwin;
      isLinux = lib.systems.inspect.predicates.isLinux;
      mkSystemFromString = lib.systems.parse.mkSystemFromString;

      nixosConfigurations = 
        lib.mapAttrs(name: value: self.system."${value}")
          (lib.filterAttrs (name: value: isLinux (mkSystemFromString value)) hosts);
     
      darwinConfigurations = 
        lib.mapAttrs(name: value: self.system."${value}")
          (lib.filterAttrs (name: value: isLinux (mkSystemFromString value)) hosts);
    in
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          isDarwinSystem = isDarwin (mkSystemFromString system);
          nixpkgs = if isDarwinSystem then inputs.nixpkgs-nixos else inputs.nixpkgs-darwin;
          nixpkgs-cfg = {
            inherit system;
            config = {
              allowUnfree = true;
              #allowBroken = true;
            };
          };
          pkgs-unstable = import inputs.nixpkgs-nixos nixpkgs-cfg;
          pkgs = import nixpkgs (nixpkgs-cfg // {
            overlays = [
              (self: super: {
                helix = pkgs-unstable.helix;
              })
            ];
          });

          specialArgs = {
            inherit inputs;
            nixos-hardware = inputs.nixos-hardware;
            unstable = pkgs-unstable;
          };

          in
          {
            system = 
              let 
                systemBase = 
                  if isDarwinSystem
                  then darwin.lib.darwinSystem else pkgs.lib.nixosSystem;
                homeManagerBase = 
                  if isDarwinSystem
                  then home-manager.darwinModules.home-manager else home-manager.nixosModules.home-manager;
              in
                systemBase {
                  modules = [
                    ./configuration.nix
                    homeManagerBase {
                      home-manager.useGlobalPkgs = true;
                      home-manager.useUserPackages = true;

                      home-manager.extraSpecialArgs = specialArgs;
                    }
                  ];
                };
      })
    //
    {
      inherit nixosConfigurations darwinConfigurations self;
    };
}