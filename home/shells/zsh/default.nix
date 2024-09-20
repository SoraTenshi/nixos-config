{ inputs, pkgs, ... }:
let
  aliases = {
    cat = "bat --style=plain --no-pager";
    mv = "mv -i";
    ls = "eza --icons --grid";
    cd = "z";
    termbin = "nc termbin.com 9999";
    grep = "rg";
    lg = "lazygit";
    dgr = "lazydocker";
    du = "du --human-readable";
    readsym = "readlink -f";
    mksym = "ln -sf";
  };
in {
  home.packages = with pkgs; [
    # Shell utils
    htop
    bottom
    eza
    ripgrep
    gh
    jq
    gh-dash
  ];

  programs = {
    fzf.enable = true;
    zoxide.enable = true;
    bat = { enable = true; };
    oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = builtins.fromJSON (builtins.unsafeDiscardStringContext
        (builtins.readFile
          "${inputs.self}/home/shells/zsh/oh-my-posh/tokyonight_ascii.opm.json"));
    };

    git = {
      enable = true;
      includes = [{ path = "~/.config/git/userconfig.inc"; }];
      lfs.enable = true;
    };

    # Shell
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      plugins = [{
        name = "zsh-you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
      }];

      initExtra = ''
        export PATH=$PATH:~/.cargo/bin:~/.local/bin:~/.roswell/bin
        export YSU_HARDCORE=1

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
  };
}
