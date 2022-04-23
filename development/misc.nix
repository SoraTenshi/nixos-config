{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go 

    pythonFull

    # Language servers (for non-main languages)
    gopls
  ];
}
