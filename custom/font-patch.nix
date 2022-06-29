{
  description = "An attempt to patch any font with the nerdfont-patcher";

  inputs = {
    font-name = {
      flake = false;
      value = "";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, font-name }:
    let
      allSystems = flake-utils.lib.eachDefaultSystem
        (system:
          let
            pkgs = import <nixpkgs> {};
            unmodifiedPackage = pkgs.font-name.override;

            nerdFontPatched =
              let outputDir = "/usr/share/fonts/truetype";
              in
              pkgs.stdenv.mkDerivation {
                pname = font-name ++ "nerd-font";
                version = unmodifiedPackage.version;
                src = pkgs."${font-name.value}".src;
                buildInputs = [ pkgs.nerd-font-patcher ];
                configure = "mkdir -p ${outputDir}";
                build = ''
                  for file in ${unmodifiedPackage}/share/fonts/truetype/*"
                  do
                  nerd-font-patcher $file --complete --outputdir ${outputDir}
                  done
                '';
              };

            packages = {
              normal = unmodifiedPackage;
              nerd-font = nerdFontPatched;
            };
          in
          {
            inherit packages;
            defaultPackage = unmodifiedPackage;
          }
        );
    in
    {
      packages = allSystems.packages;
      defaultPackages = allSystems.defaultPackage;
      overlay = final: prev: {
        font-name.value = allSystems.packages.${final.system};
      };
    };
}
