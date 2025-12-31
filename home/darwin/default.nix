{ username, ... }: {
  programs.nh = {
    enable = true;
    darwinFlake = "/Users/${username}/dev/nixos-config";
  };
}
