{ pkgs, username, ... }: {

  # system.switch = {
  #   enable = false;
  # };

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  environment.sessionVariables = {
    NH_FLAKE = "/home/${username}/dev/nixos-config";
    STEEL_HOME = "/home/${username}/.config/steel";
  };

  environment.systemPackages = with pkgs; [
    # phone
    libimobiledevice
    ifuse
    # 
    nh
    nvd
    nix-output-monitor
    zoxide
    bat
    fzf
    ripgrep
    uutils-coreutils
    linuxPackages_latest.perf
  ];
}
