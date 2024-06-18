hostname:
{ self, nixpkgs, home-manager, nur, system, username, overlays, neovim-nightly
, helix-master, zls-master, picom-ibhagwan ? null, sddm-theme ? null
, grub2-theme ? null, ags-env ? null, isHardwareMachine ? true, isVM ? false
, extraModules ? [ ], # default to an empty list if not provided
extraHomeModules ? [ ], efiSysMountPoint ? "/boot", monitors ? [ ]
, coplandos ? null, useStylix ? true, hyprland ? null }:
let
  systemSpecificOverlays = [
    (final: prev: {
      zls = zls-master.packages.${system}.default;
      helix = helix-master.packages.${system}.default;
      picom = prev.picom.overrideAttrs (c: { src = picom-ibhagwan; });
      material-symbols = prev.callPackage ../derivations/material-symbols { };
    })
  ];
  inherit (nixpkgs) lib;
in lib.nixosSystem {
  inherit system;
  specialArgs = if isHardwareMachine then {
    inherit sddm-theme grub2-theme isVM username efiSysMountPoint coplandos;
  } else {
    inherit username isVM efiSysMountPoint;
  };
  modules = [
    {
      nixpkgs.overlays = systemSpecificOverlays ++ overlays;
      nixpkgs.config.allowUnfree = true;
    }

    ../modules/user
    ../modules/font
    ../modules/time
    ../modules/cachix
    ../modules/common
    ../modules/variables
    ../modules/ssh

    nur.nixosModules.nur
    ({ config, ... }: {
      home-manager.sharedModules =
        [ config.nur.repos.rycee.hmModules.emacs-init ] ++ extraHomeModules;
    })

    # only for hardware
    # no WSL as an example
  ] ++ (if isHardwareMachine then [
    (if useStylix then ../modules/stylix else {})
    ../modules/boot
    # ../modules/x11
    ../modules/wayland
    ../modules/sound

    # End the scope, and add an additional list of the extra modules
  ] else
    [ ]) ++ extraModules ++ [
      ../machines/${hostname}

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = if isHardwareMachine then {
            inherit self neovim-nightly picom-ibhagwan username ags-env
              monitors system hyprland;
          } else {
            inherit self neovim-nightly username system;
          };
          users.${username} = { imports = [ ../profiles/${username} ]; };
        };
      }
    ];
}
