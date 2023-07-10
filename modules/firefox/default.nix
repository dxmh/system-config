{
  config,
  lib,
  ...
}: {
  options.hxy.firefox = {
    enable = lib.mkEnableOption "Enable Firefox configuration";
  };

  config = lib.mkIf config.hxy.firefox.enable {
    home-manager.users.${config.hxy.base.mainUser}.programs.firefox = {
      enable = true;

      # https://discourse.nixos.org/t/nix-macos-monthly/1230/9
      package = config.nur.repos.toonn.apps.firefox;

      extensions = with config.nur.repos.rycee.firefox-addons; [
        amp2html
        clearurls
        consent-o-matic
        cookie-autodelete
        df-youtube
        old-reddit-redirect
        reddit-enhancement-suite
        tab-reloader
        ublock-origin
        view-image
        vimium
      ];

      profiles.default = {
        id = 0;
        isDefault = true;
        search = {
          default = "DuckDuckGo";
          force = true;
        };
        settings = import ./settings.nix;
        bookmarks = import ./bookmarks.nix;
      };
    };
  };
}
