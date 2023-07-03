{ pkgs, ... }:
{
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  # Fix pipewire at some point ?!
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   audio.enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;

  #   # To be integrated
  #   # lowLatency = {
  #   #   enable = true;
  #   #   quantum = 64;
  #   #   rate = 48000;
  #   # };
  # };
  
}
