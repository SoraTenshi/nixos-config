hostname:
{ inputs, nixpkgs, home-manager, nur, system, username, overlays
, extraModules ? [ ], # extra modules
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

    ({ pkgs, ... }: {
      users.users.${username} = {
        home = "/Users/${username}";
        shell = pkgs.zsh;
      };
    })
  ] ++ extraModules ++ [
    nur.nixosModules.nur
    ({ config, ... }: {
      home-manager.sharedModules = [
        # config.nur.repos.rycee.hmModules.emacs-init
      ];
    })

    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs username; };
        users.${username} = { imports = [ ../profiles/${username} ]; };
      };
    }
  ];
}
