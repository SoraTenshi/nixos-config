# Used for the configuration of specific configurations

{ config, pkgs, dotfiles, ... }:

{
  home.packages = with pkgs; [
    # Actual Shell, with some skins
    zsh

    # Plugin i guess?
    zoxide

    # Shell utils
    bat htop
  ];

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
      cat   = "bat ";
      mv    = "mv -i ";
      cd    = "z ";
    };

    shellAliases = {
      cat   = "bat ";
      mv    = "mv -i ";
      cd    = "z ";
    };

    plugins = [{
      name = "powerlevel10k";
      src  = pkgs.zsh-powerlevel10k;
      file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    }];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" "sudo" "man" "rust"
      ];
    };
  };

  home.file = {
    ".p10k.zsh" = {
      source = "${dotfiles}/powerlevel10k/.p10k.zsh";
    };
  };
}
