{ inputs, system, pkgs, username, ... }:
{
  home.sessionVariables = {
    HELIX_STEEL_CONFIG = "/home/${username}/.config/hxs/";
    # STEEL_LSP_HOME = "/home/${username}/.config/hxs/steel-lsp";
  };

  home.packages = [ pkgs.steel ];
}
