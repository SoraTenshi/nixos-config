{ pkgs, ... }: {
  services.mullvad-vpn = {
    enable = true;
    packages = pkgs.mullvad-vpn;
  };
}
