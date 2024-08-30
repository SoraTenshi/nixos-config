{ pkgs, ... }: {
  imports = [ ./rice.nix ];
  home.packages = with pkgs; [ ani-cli ncdu tiny tldr tmate unzip ];
}
