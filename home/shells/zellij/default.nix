{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      ui = {
        pane-frames = {
          rounded-corners = false;
          hide-session-name = true;
        };
      };

      scrollback_editor = "hx";
      simplified-ui = true;
      # managed by stylix
      # theme = "tokyonight-storm";
      # themes.tokyonight-storm = {
      #   fg = "#a9b1d6";
      #   bg = "#24283b";
      #   black = "#383e5a";
      #   red = "#f93357";
      #   green = "#9ece6a";
      #   yellow = "#e0af68";
      #   blue = "#7aa2f7";
      #   magenta = "#bb9af7";
      #   cyan = "#2ac3de";
      #   white = "#c0caf5";
      #   orange = "#ff9e64";
      # };
    };
  };
}
