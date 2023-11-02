{ self, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Shell utils
    htop btop eza oh-my-posh
  ];
  
  programs = {
    fzf.enable = true;
    zoxide.enable = true;
    bat = {
      enable = true;
      config = {
        theme = "base16";
      };
    };
    nushell = {
      enable = true;
      configFile.text = ''
        alias cat = bat --style=plain
        alias mv = mv -i
        alias ls = eza --icons
        alias cd = z
        alias termbin = nc termbin.com 9999
        source ${self}/oh-my-posh/tokyonight_ascii_nu.opm.json 
      '';
    };
  };
}
