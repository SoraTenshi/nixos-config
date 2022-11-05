{ config, ... }:
{
  nix.settings = {
    auto-optimise-store = true;
    builder-use-substitutes = true;
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [
      "https://nix-community.cachix.org"
      "https://helix.cachix.org"
    ];
    
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
    
    trusted-users = [ "root" "@wheel" ];
  };
}
