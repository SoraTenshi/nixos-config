hostname:
{ self
, nixpkgs
, home-manager
, nur
, system
, username
, overlays
, neovim-nightly
, helix-master
, zls-master
, darwin
, extraModules ? [] # extra modules
, nix-colors
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
    ({ config, ... }:{
      home-manager.sharedModules = [
        config.nur.repos.rycee.hmModules.emacs-init
      ];
    })

    home-manager.darwinModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit
            self neovim-nightly username nix-colors;
        };
        users.${username} = {
          imports = [ ../profiles/${username} ];
        };
      };
    }
  ];
}
