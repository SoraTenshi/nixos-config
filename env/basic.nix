{ pkgs, ... }:

let
  defaultUser = "dreamer";
in
{
  imports = [
    ./shared.nix
  ];

  programs.zsh.enable = true;
  users.users.${defaultUser} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    password = "12345";
    extraGroups = [ "wheel" ];
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Berlin";
  };

  services.openssh.enable = true;
  virtualisation.docker.enable = true;
  programs.ssh.startAgent = true;

  system.stateVersion = "unstable";
}
