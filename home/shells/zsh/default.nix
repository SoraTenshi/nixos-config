{ self, pkgs, ... }:

let 
  aliases = {
    cat      = "bat --style=plain ";
    mv       = "mv -i ";
    ls       = "exa --icons ";
    cd       = "z ";
    termbin  = "nc termbin.com 9999"; 
    grep     = "rg ";
    lg       = "lazygit";
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
    themes = {
      tokyonight-storm = builtins.readFile ./tokyonight_storm.tmTheme;
    };
    config.theme = "tokyonight-storm";
  };

  programs.git = {
    enable = true;
    userName = "SoraTenshi";
    userEmail = "dream@neoncity.dev";
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      init.defaultBranch = "main";
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
      eval "$(oh-my-posh init zsh --config '~/.config/oh-my-posh/tokyonight_ascii.opm.json')"
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
  
  xdg.configFile."oh-my-posh" = {
    source = "${self}/home/shells/zsh/oh-my-posh";
  };
}
