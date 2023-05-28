{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    amdvlk
    dxvk
    
    winetricks
    vulkan-tools
    openssl
    gnome.zenity
  ];

  boot.kernel.sysctl = { "abi.vsyscall32" = 0; };
  environment.sessionVariables = { QT_X11_NO_MITSHM = "1"; };

  hardware.nvidia = {
    modesetting.enable = true;
  };
  
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
