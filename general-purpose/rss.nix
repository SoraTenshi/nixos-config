{ pkgs, ... }:
{
  programs.newsboat = {
    enable = true;
    urls = [
      {
        url = "http://blog.fefe.de/rss.xml?html";
        title = "Fefe's Blog";
      }
      {
        url = "https://www.microsoft.com/en-us/research/feed/";
        title = "Microsoft Research";
      }
      {
        url = "https://research.googleblog.com/feeds/posts/default?alt=rss";
        title = "Google Research";
      }
      {
        url = "https://github.blog/feed/";
        title = "GitHub Blog";
      }
      {
        url = "https://github.blog/category/engineering/feed/";
        title = "GitHub Engineering";
      }
      {
        url = "https://ziglang.org/news/index.xml";
        title = "Ziglang News";
      }
      {
        url = "https://zig.news/rss";
        title = "zig.news";
      }
      {
        url = "https://devblogs.microsoft.com/oldnewthing/feed";
        title = "old new thing";
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
