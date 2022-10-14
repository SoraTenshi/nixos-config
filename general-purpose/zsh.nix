# Used for the configuration of specific configurations

{ self, config, pkgs, ... }:


let 
  aliases = {
    cat      = "bat --style=plain ";
    mv       = "mv -i ";
    ls       = "exa --icons ";
    cd       = "z ";
    termbin  = "nc termbin.com 9999"; 
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

    initExtra = ''
      eval "$(zoxide init zsh)"
      eval "$(oh-my-posh init zsh --config '/home/dreamer/.oh-my-posh/tokyonight_ascii.opm.json')"

      export KEY_SHIFT_CMD_LEFT=$'^[[1;10D'
      export KEY_SHIFT_CMD_RIGHT=$'^[[1;10C'
      export KEY_DEL=$'^[[3~' # Del
      export KEY_BACKSPACE=$'^?' # Backspace
      
    '';

    shellAliases = aliases;
  };
  
  home.file.".oh-my-posh" = {
    source = "${self}/oh-my-posh";
  };
}
