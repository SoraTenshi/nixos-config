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
      material-symbols = prev.callPackage ./derivations/material-symbols {};
    })
  ];
in
nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = if isHardwareMachine then { inherit sddm-theme grub2-theme; } else {};
  modules = [
    { nixpkgs.overlays = systemSpecificOverlays ++ overlays; }

    ../machines/${hostname}

  ] ++ extraModules ++ [
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
