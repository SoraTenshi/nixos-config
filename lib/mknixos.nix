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
in
lib.nixosSystem {
  inherit system;
  specialArgs = if isHardwareMachine then { inherit sddm-theme grub2-theme; } else {};
  modules = [
    { nixpkgs.overlays = systemSpecificOverlays ++ overlays; }
    ../modules/user
    ../modules/font
    ../modules/time
    ../modules/cachix
    ../modules/common
    ../modules/variables
    ../modules/ssh

    ../machines/${hostname}

    # only for hardware
    # no WSL as an example
  ] ++ (if isHardwareMachine then [
    ../modules/boot
    ../modules/sddm
    ../modules/sound
    ../modules/wayland
    ../modules/x11
  # End the scope, and add an additional list of the extra modules
  ] else []) ++ extraModules ++ [
    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = if isHardwareMachine then {
          inherit
            self neovim-nightly picom-ibhagwan username;
        } else {
          inherit
            self neovim-nightly username;
        };
        users.${username} = {
          imports = [ ../profiles/${username} ];
        };
      };
    }
  ];
}
