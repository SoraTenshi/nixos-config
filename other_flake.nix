{
  inputs = {
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # Darwin specific
    nixpkgs-darwin = {
      url = "github.com:NixOS/nixpkgs/nixpkgs-23.05-darwin";
      follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      follows = "nixpkgs";
    };
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";


    nur = {
      url = "github:nix-community/NUR";
      follows = "nixpkgs-nixos";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      follows = "nixpkgs";
    };

    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      follows = "nixpkgs";
    };

    zig-overlay = {
      url = "github:mitchellh/zig-overlay";
      follows = "nixpkgs";
    };

    helix-master = {
      url = "github:SoraTenshi/helix/new-daily-driver";
      follows = "nixpkgs";
    };

    grub2-theme.url = "github:vinceliuice/grub2-themes";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    zls-master.url = "github:zigtools/zls/master";

    flake-utils.url = "github:numtide/flake-utils";

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
      system = builtins.currentSystem;
    in
    {
      
    };
}
