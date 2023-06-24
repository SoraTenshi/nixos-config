hostname:
{ self
, nixpkgs
, home-manager
, system
, user
, overlays
, neovim-nightly
, helix-master
}:

nixpkgs.lib.nixosSystem {
  inherit system;
  modules = [
    { nixpkgs.overlays = overlays; }

    (/. + "${self}/machines/${hostname}")

    home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit
            self neovim-nightly helix-master;
        };
        users.${user} = {
          imports = [ ./profiles/${user} ];
        };
      };
    }
  ];
}
