{ self, zls-overlay, pkgs, config, ... }:

{
  home.packages = with pkgs; [
    zigpkgs.master
    odin
  
    # tooling
    lazygit

    # build zig
    lld_14
    llvmPackages_14.llvm llvmPackages_14.libllvm

    # debugger
    gdb

    # compiler
    clang go nim cargo rustc julia-bin
    elixir gleam erlang
    idris2 

    nasm

    # practice
    exercism

    # interpreter
    nodejs guile

    # cmake
    cmake mmake
  ];

  xdg.configFile."zls.json".text = builtins.toJSON {
    "$schema" = "https://raw.githubusercontent.com/zigtools/zls/master/schema.json";
    enable_ast_check_diagnostics = true;
    enable_autofix = false;
    enable_import_embedfile_argument_completions = true;
    enable_inlay_hints = true;
    enable_semantic_tokens = true;
    enable_snippets = true;
    max_detail_length = 104857;
    operator_completions = true;
    use_comptime_interpreter = true;
    warn_style = true;
    zig_exe_path = "${pkgs.zigpkgs.master.outPath}/bin/zig";
  };
}
