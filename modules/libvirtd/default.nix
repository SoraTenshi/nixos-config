{ pkgs, username, ... }:
{
  environment.systemPackages = [ pkgs.swtpm ];
  systemd.services.libvirtd.path = [ pkgs.swtpm ];

  virtualisation = {
    libvirtd = {
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu.ovmf.enable = true;
      qemu.runAsRoot = true;
      deviceACL = [
        "/dev/vfio/vfio"
        "/dev/kvm"
        "/dev/kvmfr0"
        "/dev/null"
      ];
    };

    vfio = {
      enable = true;
      IOMMUType = "amd";
      devices = [
        "10de:2216" # rtx 3080
        "10de:1aef" # audio controller (nvidia)
      ];
    };

    kvmfr = {
      enable = true;
      devices = [
        {
          resolution = {
            width = 1920;
            height = 1080;
            pixelFormat = "rgba32";
          };

          permissions = {
            user = username;
            group = "qemu-libvirtd";
            mode = "0660";
          };
        }
      ];
    };

    spiceUSBRedirection.enable = true;
  };
}
