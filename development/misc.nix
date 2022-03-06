{ pkgs, ... }:
{
  home.packages = with pkgs; [
    swift
    
    go

    pythonFull
  ];
}
