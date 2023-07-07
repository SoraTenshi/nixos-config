hostname:
{ self
, nixpkgs
, home-manager
, system
, username
, overlays
, neovim-nightly
, helix-master
, zls-master
, picom-ibhagwan ? null
, sddm-theme ? null
, grub2-theme ? null
, isHardwareMachine ? true
, extraModules ? [] # default to an empty list if not provided
, nix-colors
}:

let 
  systemSpecificOverlays = [
    (final: prev: {
      zls = zls-master.packages.${system}.default;
      helix = helix-master.packages.${system}.default;
      picom = prev.picom.overrideAttrs (c: { src = picom-ibhagwan; });
      material-symbols = prev.callPackage ../derivations/material-symbols {};
    })
  ];
  lib = nixpkgs.lib;
  color-scheme = nix-colors.colorSchemes.tokyo-night-storm;
in
lib.nixosSystem {
  inherit system;
  specialArgs = if isHardwareMachine then { inherit sddm-theme grub2-theme username; } 
    else { inherit username; };
  modules = [
    {
      nixpkgs.overlays = systemSpecificOverlays ++ overlays;
      nixpkgs.config.allowUnfree = true;
    }

    ../modules/user
    ../modules/font
    ../modules/time
    ../modules/cachix
    ../modules/common
    ../modules/variables
    ../modules/ssh

    # only for hardware
    # no WSL as an example
  ] ++ (if isHardwareMachine then [
    ../modules/boot
    ../modules/x11
    ../modules/wayland
    ../modules/sddm
    ../modules/sound
  # End the scope, and add an additional list of the extra modules
  ] else []) ++ extraModules ++ [
    ../machines/${hostname}

    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = if isHardwareMachine then {
          inherit
            self neovim-nightly picom-ibhagwan username color-scheme;
        } else {
          inherit
            self neovim-nightly username color-scheme;
        };
        users.${username} = {
          imports = [ ../profiles/${username} ];
        };
      };
    }
  ];
}
