{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go nim

    # Language servers (for non-main languages)
    gopls rnix-lsp
  ];
}
