{ pkgs, ... }: {
  imports = [ ./common-lisp.nix ];
  home.packages = with pkgs; [
    # some commonly used compiler stuff
    zig
    guile
    cargo
    rustc
    go
    elixir
    python311 # i can't get around it and i'm tired of always using a nix shell
    hy
  ];
}
