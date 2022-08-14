{
  description = "A nix-shell for my pentesting purposes";
  nixConfig.bash-prompt = "\[ctf\]~ ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , ...
    }:

    flake-utils.lib.eachDefaultSystem
      (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system}; 
        nixpkgs.config.allowUnfree = true;
      in
      {
        devShell =
        pkgs.mkShell
        {
          packages = with pkgs; [
            # dependencies
            pwntools
            python310Packages.pwntools
            python310Full
            python-language-server

            # web
            sqlmap
            # requires unfree!
            burpsuite

            # pwn
            gdb
            pwndbg
            one_gadget

            # rev
            ghidra
          ];
        };
      });
  }
