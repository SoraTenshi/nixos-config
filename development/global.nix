{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # always useful
    git
    
    docker

    # cmake 
    cmake
  ];
}
