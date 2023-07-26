{ self, pkgs, ... }:

let 
  aliases = {
    cat      = "bat --style=plain ";
    mv       = "mv -i ";
    ls       = "exa --icons --grid";
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
    gh jq gh-dash
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
      export PATH=$PATH:~/.cargo/bin

      # Define autocomplete for devshell init
      devshell() {
        nix flake init --template github:the-nix-way/dev-templates#$1
      }

      _devshell() {
        compadd clojure csharp cue dhall elixir elm gleam go \
           hashi haskell java kotlin latex nickel nim nix node ocaml \
           opa php protobuf purescript python ruby rust-toolchain rust scala shell zig
      }
      compdef _devshell devshell
      # End definition of devshell

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
