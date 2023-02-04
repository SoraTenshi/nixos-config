{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vulkan-loader

    winetricks
    (lutris.override {
      lutris-unwrapped = lutris-unwrapped.override {
        wine = wineWowPackages.staging;
      };
    })
  ];
  
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
