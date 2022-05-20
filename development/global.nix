{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # ui dev
    gtk3 gtk4

    # always useful
    git

    # cmake 
  ];
}
