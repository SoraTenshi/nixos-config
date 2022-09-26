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
      eval "$(oh-my-posh init zsh --config 'https://raw.githubusercontent.com/s0LA1337/nixos-config/master/general-purpose/posh/default.omp.json')"
      # [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
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

    # plugins = [{
    #   name = "powerlevel10k";
    #   src  = pkgs.zsh-powerlevel10k;
    #   file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    # }];
  };

  home.file = {
    ".p10k.zsh" = {
      source = "${dotfiles}/powerlevel10k/.p10k.zsh";
    };
  };
}
