{ pkgs, username, ... }:
{
  users.groups.qemu-libvirtd = {};
  users.users.qemu-libvirtd.group = "qemu-libvirtd";
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu.ovmf.enable = true;
      qemu.swtpm.enable = true;

      qemu.package = pkgs.qemu_kvm;
      qemu.runAsRoot = true;
      deviceACL = [
        "/dev/vfio/vfio"
        "/dev/kvm"
        "/dev/kvmfr0"
        "/dev/null"
      ];

      scopedHooks.qemu = {
        "10-rewire-gpu" = {
          enable = true;
          scope = {
            objects = [ "win11" ];
            operations = [ "prepare" ];
          };
          script = ''
          echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

          modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia

          #unbind gpu
          virsh nodedev-detach pci_0000_08_00_0
          virsh nodedev-detach pci_0000_08_00_1

          modprobe vfio-pci
          '';
        };

        "10-undo-rewire-gpu" = {
          enable = true;
          scope = {
            objects = [ "win11" ];
            operations = [ "release" ];
          };
          script = ''
          virsh nodedev-reattach pci_0000_08_00_1
          virsh nodedev-reattach pci_0000_08_00_0

          modprobe nvidia
          modprobe nvidia_modeset
          modprobe nvidia_uvm
          modprobe nvidia_drm

          echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind
          '';
        };
      };
    };

    vfio = {
      enable = true;
      IOMMUType = "amd";
      ignoreMSRs = true;
      # devices = [
      #   "10de:2216" # rtx 3080
      #   "10de:1aef" # audio controller (nvidia)
      # ];
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
