{ pkgs, system, ... }: {
  home.packages = with pkgs; [
    # Formatting
    alejandra

    # Debugging stuff
    lldb

    # Language servers
    clang-tools # C-Style
    cmake-language-server # Cmake, pray to never need to use it
    gopls # Go
    nil # Nix
    rust-analyzer # Rust
    texlab # LaTeX
    zls # Zig
    elixir_ls # Elixir
    clojure-lsp # Clojure

    haskellPackages.haskell-language-server # Haskell

    nodePackages.typescript-language-server # Typescript
    nodePackages.vim-language-server # Vim
    nodePackages.yaml-language-server # YAML / JSON

    luajitPackages.lua-lsp # Lua
  ] ++ (if system == "x86_64-linux" then [ols] else []); # Odin!

  # xdg.configFile."zls.json".text = builtins.toJSON {
  #   "$schema" =
  #     "https://raw.githubusercontent.com/zigtools/zls/master/schema.json";
  #   enable_ast_check_diagnostics = true;
  #   enable_autofix = true;
  #   enable_import_embedfile_argument_completions = true;
  #   enable_inlay_hints = true;
  #   inlay_hints_hide_redundant_param_names = true;
  #   inlay_hints_hide_redundant_param_names_last_token = true;
  #   enable_semantic_tokens = true;
  #   enable_snippets = true;
  #   max_detail_length = 104857;
  #   operator_completions = true;
  #   warn_style = true;
  #   include_at_in_builtins = true;
  #   zig_exe_path = "${pkgs.zigpkgs.master.outPath}/bin/zig";
  # };
}
