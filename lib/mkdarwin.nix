hostname:
{ self
, nixpkgs
, home-manager
, system
, user
, overlays
, neovim-nightly
, helix-master
, zls-master
, darwin
, extraModules ? [] # extra modules
}:

let 
  systemSpecificOverlays = [
    (final: prev: {
      zls = zls-master.packages.${system}.default;
      helix = helix-master.packages.${system}.default;
    })
  ];
in
darwin.lib.darwinSystem rec {
  inherit system user;
  modules = [
    { nixpkgs.overlays = systemSpecificOverlays ++ overlays; }

    "${self}/machines/${hostname}"
    "${self}/darwin"
    "${self}/modules/font"
    "${self}/modules/user"

  ] ++ extraModules ++ [
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit
            self neovim-nightly user;
        };
        users.${user} = {
          imports = [ ../profiles/${user} ];
        };
      };
    }
  ];
}
