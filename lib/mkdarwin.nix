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
darwin.lib.darwinSystem {
  inherit system;
  modules = [
    { nixpkgs.overlays = systemSpecificOverlays ++ overlays; }

    ../machines/${hostname}
    ../darwin
    ../modules/font

  ] ++ extraModules ++ [
    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
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
