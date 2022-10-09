# Used for the configuration of specific configurations

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Actual Shell, with some skins
    zsh

    # path finder
    zoxide

    # Shell utils
    btop exa oh-my-posh
  ];
  
  programs.bat = {
    enable = true;
    config = {
      theme = "base16";
    };
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
      ".."     = "cd ..";
    };

    shellAliases = {
      cat      = "bat --style=plain ";
      mv       = "mv -i ";
      cd       = "z ";
      ls       = "exa --icons ";
      ".."     = "cd ..";
    };
  };
}
