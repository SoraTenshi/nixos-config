{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # always useful
    git

    # cmake 
    cmake
  ];
}
