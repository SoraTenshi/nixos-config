{ pkgs, username, ... }: {

  system.nixos-init.enable = false;

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  environment.sessionVariables = {
    STEEL_HOME = "/home/${username}/.config/steel";
  };

  programs.nh = {
    enable = true;
    flake = "/home/${username}/dev/nixos-config";
  };

  environment.systemPackages = with pkgs; [
    # phone
    libimobiledevice
    ifuse
    nvd
    nix-output-monitor
    zoxide
    bat
    fzf
    ripgrep
    uutils-coreutils
    perf
  ];
}
