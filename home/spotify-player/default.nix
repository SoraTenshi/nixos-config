_: {
  programs.spotify-player = {
    enable = true;
    settings = {
      # theme = "tokyonight";
      client_id = "2f073e67c0184423a75e8666ede0c623";
      client_port = 8888;
      notify_format = { summary = "{track}"; body = "{artists}"; };
      device = {
        volume = 50;
        normalization = true;
        autoplay = true;
      };
    };
  };
}
