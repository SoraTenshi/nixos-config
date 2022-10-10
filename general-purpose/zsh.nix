# Used for the configuration of specific configurations

{ self, config, pkgs, ... }:


let 
  aliases = {
    cat      = "bat --style=plain ";
    mv       = "mv -i ";
    cd       = "z ";
    ls       = "exa --icons ";
    ".."     = "cd ..";
  };
in
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

  # Shell
  programs.zsh = {
    enable                   = true;
    enableCompletion         = true;
    enableAutosuggestions    = true;
    enableSyntaxHighlighting = true;
    defaultKeymap            = "vicmd";

    initExtra = ''
      eval "$(zoxide init zsh)"
      eval "$(oh-my-posh init zsh --config '/home/dreamer/oh-my-posh/tokyonight_ascii.opm.json')"
    '';

    shellAliases = aliases;
  };
  
  home.file.".oh-my-posh" = {
    source = "${self}/oh-my-posh";
  };
}
