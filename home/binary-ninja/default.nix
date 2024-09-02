{ inputs, system, ... }: 
let
  filePath = ./binary-ninja-personal.zip;
  fileHash = if builtins.pathExists filePath then builtins.hashFile "sha256" filePath else null;
  storePath = if fileHash != null then "/nix/store/${fileHash}-binary-ninja-personal.zip" else null;
  fileInStore = if storePath != null then builtins.pathExists storePath else false;
in
{
  home.packages = (if fileInStore then [
    inputs.binary-ninja.outputs.packages.${system}.binary-ninja-personal-wayland
  ] else []);
}
