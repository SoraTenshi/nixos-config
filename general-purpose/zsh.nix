# Used for the configuration of specific configurations

{ config, pkgs, dotfiles, ... }:

{
  home.packages = with pkgs; [
    # Actual Shell, with some skins
    zsh

    # Plugin i guess?
    zoxide

    # Shell utils
    btop exa
    
    oh-my-posh
  ];
  
  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
    # themes = {
    #   tokyonight_storm = {
        
    #   };
    # };
  };

  # Shell
  programs.zsh = {
    enable                = true;
    enableCompletion      = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    initExtra = ''
      eval "$(zoxide init zsh)"
      eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/s0LA1337/nixos-config/master/oh-my-posh/tokyonight_ascii.opm.json')"
    '';

    shellGlobalAliases = {
      cat      = "bat --style=plain ";
      mv       = "mv -i ";
      cd       = "z ";
      ls       = "exa --icons ";
    };

    shellAliases = {
      cat      = "bat --style=plain ";
      mv       = "mv -i ";
      cd       = "z ";
      ls       = "exa --icons ";
    };
  };
}
