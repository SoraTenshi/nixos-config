# Used for the configuration of specific configurations

{ config, pkgs, dotfiles, ... }:

{
  # Enable the usage of home-manager
  # The point of home-manager is to create
  # symlinks from /nix/store
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Actual Shell, with some skins
    zsh

    # correct :D
    thefuck

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
    # enableSyntaxHighlighting = true;

    # this needs some work, the colourscheme fits, but i dislike the design
    initExtra = ''
    eval "$(zoxide init zsh)"
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';

    shellGlobalAliases = {
      vim     = "nvim ";
      sudo    = "sudo ";
      cat     = "bat ";
      mv      = "mv -i ";
      cd      = "z ";
      thefuck = "fuck ";
    };

    shellAliases = {
      vim     = "nvim ";
      sudo    = "sudo ";
      cat     = "bat ";
      mv      = "mv -i ";
      cd      = "z ";
      thefuck = "fuck ";
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
