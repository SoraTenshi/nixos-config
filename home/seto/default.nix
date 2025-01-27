{ inputs, system, ... }: {
  programs.seto = {
    enable = true;
    package = inputs.seto.packages.${system}.default;
  };
}
