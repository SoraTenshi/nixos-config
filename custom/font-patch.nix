{
  description = "An attempt to patch any font with the nerdfont-patcher";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    let
      allSystems = flake-utils.lib.eachDefaultSystem
        (system: {
          defaultPackages = allSystems.defaultPackage;
        });
      outputDir = "/usr/share/fonts/truetype";
    in
    {
      overlay = final: prev: {
        mkNerdFont = { font-drv }: prev.stdenv.mkDerivation {
          pname = font-drv.pname ++ "nerd-font";
          version = font-drv.version;
          src = font-drv.src;
          nativeBuildInputs = [ prev.nerd-font-patcher ];
          configure = "mkdir -p ${outputDir}";
          build = ''
            for file in ${font-drv}/share/fonts/truetype/*"
            do
            nerd-font-patcher $file --complete --outputdir ${outputDir}
            done
          '';
        };
      };
    };
}
