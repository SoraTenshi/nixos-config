hostname:
{ inputs, nixpkgs, system, username, overlays
, extraModules ? [ ], extraHomeModules ? [ ] # extra modules
}:
let
  systemSpecificOverlays = [
    (final: prev: {
      zls = inputs.zls-master.packages.${system}.default;
      helix = inputs.helix-master.packages.${system}.default;
    })
  ];
in inputs.darwin.lib.darwinSystem {
  inherit system;
  modules = [
    {
      nixpkgs.overlays = systemSpecificOverlays ++ overlays;
      nixpkgs.config.allowUnfree = true;
    }

    ../machines/${hostname}
    ../darwin
    ../modules/font
  ] ++ extraModules ++ [
    inputs.home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs username system; };
        users.${username} = { imports = [ ../profiles/${username} ]; };
      };
    }
  ];
}
