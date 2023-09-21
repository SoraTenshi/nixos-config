{ pkgs, ... }:
{
  sound.enable = true;
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
