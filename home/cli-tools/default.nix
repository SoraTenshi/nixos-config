{ pkgs, ... }: {
  imports = [ ./rice.nix ];
  home.packages = with pkgs; [ ani-cli gomuks ncdu tiny tldr tmate unzip ];
}
