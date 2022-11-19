{ self, zls-overlay, pkgs, config, ... }:

{
  home.packages = with pkgs; [
    zigpkgs.master
  
    # tooling
    lazygit

    # build zig
    lld_14
    llvmPackages_14.llvm llvmPackages_14.libllvm

    # debugger
    gdb

    # compiler
    clang go nim cargo rustc julia-bin
    elixir
    idris2 
    
    # interpreter
    nodejs

    # cmake
    cmake 
  ];

  xdg.configFile."zls.json".text = (builtins.toJSON {
    "$schema" = "https://raw.githubusercontent.com/zigtools/zls/master/schema.json";
    zig_exe_path = "${pkgs.zigpkgs.master.outPath}/bin/zig";
    enable_snippets = true;
    enable_ast_check_diagnostics = true;
    enable_autofix = false;
    enable_import_embedfile_argument_completions = true;
    warn_style = true;
    enable_semantic_tokens = true;
    enable_inlay_hints = true;
    operator_completions = true;
    include_at_in_builtins = false;
    max_detail_length = 104857;
  });
}
