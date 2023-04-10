{config, ...}: {
  services.rss2email = {
    enable = true;
    config = {
      from = "dom@hxy.io";
      force-from = true;
      html-mail = true;
    };
    feeds = {
      lobsters.url = "https://lobste.rs/rss";
      nixos.url = "https://nixos.org/news-rss.xml";
      helix.url = "https://helix-editor.com/atom.xml";
    };
    interval = "*-*-* 05:20:00";
    to = "${config.hxy.base.mainUser}";
  };
}
