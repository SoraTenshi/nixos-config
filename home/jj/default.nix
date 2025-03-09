_: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "SoraTenshi";
        email = "dream@neoncity.dev";
      };
      ui = {
        editor = "hx";
        paginate = "never";
        merge-editor = ":builtin";
        default-command = ["log" "--reversed"];
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };
    };
  };
}
