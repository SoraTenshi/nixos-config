_:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemuOvmf = true;
      qemuRunAsRoot = true;
    };

    useSecureBoot = true;
    spiceUSBRedirection.enable = true;
  };
}
