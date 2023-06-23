# Used for the configuration of specific configurations

{ self, pkgs, ... }:


let 
  aliases = {
    cat      = "bat --style=plain ";
    mv       = "mv -i ";
    ls       = "exa --icons ";
    cd       = "z ";
    termbin  = "nc termbin.com 9999"; 
    grep     = "rg ";
  };
in
{
  home.packages = with pkgs; [
    # Shell utils
    btop exa oh-my-posh ripgrep
    gh jq
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
      # eval "$(zellij setup --generate-auto-start zsh)"

      bindkey '^[[1~'   beginning-of-line   # home
      bindkey '^[[4~'   end-of-line         # end
      bindkey '\e[3~'   delete-char         # delete
      bindkey '\eOc'    forward-word        # ctrl right
      bindkey '\eOd'    backward-word       # ctrl left
      bindkey '^[[1;5C' forward-word        # ctrl right
      bindkey '^[[1;5D' backward-word       # ctrl left
      bindkey '^H'      backward-kill-word  # ctrl backspace
    '';

    shellAliases = aliases;
  };
  
  home.file.".oh-my-posh" = {
    source = "${self}/home/shells/zsh/oh-my-posh";
  };
}
