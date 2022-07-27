# Used for the configuration of specific configurations

{ config, pkgs, dotfiles, ... }:

{
  home.packages = with pkgs; [
    # Actual Shell, with some skins
    zsh

    # Plugin i guess?
    zoxide

    # Shell utils
    htop exa
  ];
  
  programs.bat = {
    enable = true;
    # config = {
    #   theme = "Tokyo Night Storm";
    # };
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
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
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

    plugins = [{
      name = "powerlevel10k";
      src  = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }];
  };

  home.file = {
    ".p10k.zsh" = {
      source = "${dotfiles}/powerlevel10k/.p10k.zsh";
    };
  };
}
