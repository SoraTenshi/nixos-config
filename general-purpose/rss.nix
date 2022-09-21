{ pkgs, ... }:
{
  programs.newsboat = {
    enable = true;
    urls = [
      {
        url =  "";
        title = "";
      }
    ];
    maxItems = 20;
    extraConfig = ''
      unbind-key ENTER
      unbind-key j
      unbind-key k
      unbind-key J
      unbind-key K
      unbind-key TAB

      bind-key j down
      bind-key k up
      bind-key l open
      bind-key h quit
      bind-key TAB next-unread
    '';
  };
}
