hostname:
{ inputs, nixpkgs, system, username, overlays
, isHardwareMachine ? true, isVM ? false
, extraModules ? [ ] # default to an empty list if not provided
, extraHomeModules ? [ ], monitors ? [ ] , useStylix ? true
, useSecureBoot ? false, useWireguard ? false, useArcan ? false
, useAndroidEmulation ? false, useChromium ? false, autostart ? [ ]
, useTokyoNight ? true, useDualBoot ? false }:
let
  systemSpecificOverlays = [
    (final: prev: {
      zls = inputs.zls-master.packages.${system}.default;
      helix = inputs.helix-master.packages.${system}.default;
      picom = prev.picom.overrideAttrs (c: { src = inputs.picom-ibhagwan; });
      material-symbols = prev.callPackage ../derivations/material-symbols { };
      shutdown-script-ros = prev.callPackage ../derivations/shutdown-script { };
      lem-sdl2 = inputs.lem.packages.${system}.lem-sdl2;
    })
  ];
  inherit (nixpkgs) lib;
in lib.nixosSystem {
  inherit system;
  specialArgs = if isHardwareMachine then {
    inherit inputs isVM username useTokyoNight useSecureBoot useDualBoot;
  } else {
    inherit username isVM useTokyoNight;
  };
  modules = [
    {
      nixpkgs.overlays = systemSpecificOverlays ++ overlays;
      nixpkgs.config.allowUnfree = true;
    }

    ../modules/boot
    ../modules/cachix
    ../modules/common
    ../modules/flatpak
    ../modules/font
    ../modules/ssh
    ../modules/time
    ../modules/user
    ../modules/variables
    (if useAndroidEmulation then ../modules/waydroid else {})
    (if useArcan then ../modules/arcan else {})
    (if useWireguard then ../modules/wireguard else {})

    inputs.nur.modules.nixos.default
    ({ pkgs, ... }: {
      home-manager.sharedModules = [
          pkgs.nur.repos.rycee.hmModules.emacs-init
      ] ++ extraHomeModules;
    })

    # only for hardware
    # no WSL as an example
  ] ++ (if isHardwareMachine then [
    (if useStylix then ../modules/stylix else {})
    # ../modules/x11
    ../modules/wayland
    ../modules/sound
    # ../modules/mullvad
    ../modules/qmk

    # End the scope, and add an additional list of the extra modules
  ] else
    [ ]) ++ extraModules ++ [
      ../machines/${hostname}

      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = if isHardwareMachine then {
            inherit inputs username monitors system useChromium autostart useTokyoNight;
          } else {
            inherit inputs username system useTokyoNight;
          };
          users.${username} = { imports = [ ../profiles/${username} ]; };
        };
      }
    ];
}
