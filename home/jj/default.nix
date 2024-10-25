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
      };
      signing = {
        sign-all = true;
        backend = "ssh";
        key = "~/.ssh/id_ed25519.pub";
      };
    };
  };
}
