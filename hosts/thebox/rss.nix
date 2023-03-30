{config, ...}: {
  services.rss2email = {
    enable = true;
    config = {
      digest = true;
      digest-type = "multipart/mixed";
      from = "dom@hxy.io";
      force-from = true;
      html-mail = true;
    };
    feeds = {
      nixos.url = "https://nixos.org/news-rss.xml";
    };
    interval = "*-*-* 05:20:00";
    to = "${config.hxy.base.mainUser}";
  };
}
