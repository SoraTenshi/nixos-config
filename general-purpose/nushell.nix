{ self, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Shell utils
    btop exa oh-my-posh
  ];
  
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
  };

  programs.nushell = {
    enable = true;
    configFile.text = ''
      alias cat = bat --style=plain
      alias mv = mv -i
      alias ls = exa --icons
      alias cd = z
      alias termbin = nc termbin.com 9999
      source ${self}/oh-my-posh/tokyonight_ascii_nu.opm.json 
    '';
  };
}
