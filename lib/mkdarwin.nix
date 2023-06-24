hostname:
{ self
, nixpkgs
, home-manager
, system
, user
, overlays
, neovim-nightly
, helix-master
, darwin
}:

darwin.lib.darwinSystem {
  inherit system;
  modules = [
    { nixpkgs.overlays = overlays; }

    (/. + "${self}/machines/${hostname}")
    (/. + "${self}/darwin")

    home-manager.darwinModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit
            self neovim-nightly helix-master;
        };
        users.${user} = import (/. + "${self}/profiles/${user}");
      };
    }
  ];
}
