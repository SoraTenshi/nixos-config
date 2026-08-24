{ pkgs, username, ... }: {
  users.users.${username} = {
    home =
      "${if pkgs.stdenvNoCC.hostPlatform.isDarwin then "/Users" else "/home"}/${username}";

    shell = pkgs.zsh;
    isNormalUser = true;
    group = "users";
    password = "12345";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "docker"
      "qemu-libvirtd"
      "libvirtd"
      "kvm"
    ];
  };
}
