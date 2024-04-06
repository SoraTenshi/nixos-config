{pkgs, ...}: {
  home.packages = with pkgs; [
    lazydocker

    gitu

    # some commonly used compiler stuff
    zigpkgs.master
    guile
    cargo
    rustc
    go
    elixir
    python311 # i can't get around it and i'm tired of always using a nix shell

    roswell
  ];
}
