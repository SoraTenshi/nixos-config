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
    })
  ];
in
darwin.lib.darwinSystem {
  inherit system;
  modules = [
    { nixpkgs.overlays = systemSpecificOverlays ++ overlays; }

    "${self}/machines/${hostname}"
    "${self}/darwin"

  ] ++ extraModules ++ [
    home-manager.darwinModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit
            self neovim-nightly helix-master user;
        };
        users.${user} = import "${self}/profiles/${user}";
      };
    }
  ];
}
